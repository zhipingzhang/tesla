package io.github.tesla.gateway.netty.transmit.connection;

import com.google.common.collect.Lists;
import io.github.tesla.filter.service.definition.PluginDefinition;
import io.github.tesla.filter.utils.NetworkUtil;
import io.github.tesla.filter.utils.ProxyUtils;
import io.github.tesla.gateway.netty.HttpFiltersAdapter;
import io.github.tesla.gateway.netty.HttpProxyServer;
import io.github.tesla.gateway.netty.transmit.ConnectionState;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.Channel;
import io.netty.channel.ChannelPipeline;
import io.netty.handler.codec.http.*;
import io.netty.handler.timeout.IdleStateHandler;
import io.netty.handler.traffic.GlobalTrafficShapingHandler;
import io.netty.util.AsciiString;
import io.netty.util.CharsetUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.springframework.util.CollectionUtils;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.UnknownHostException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.RejectedExecutionException;
import java.util.regex.Pattern;

import static io.github.tesla.gateway.netty.transmit.ConnectionState.*;

/**
 * <p>
 * Represents a connection from a client to our proxy. Each ClientToProxyConnection can have multiple
 * {@link ProxyToServerConnection}s, at most one per outbound host:port.
 * </p>
 *
 * <p>
 * Once a ProxyToServerConnection has been created for a given server, it is continually reused. The
 * ProxyToServerConnection goes through its own lifecycle of connects and disconnects, with different underlying
 * {@link Channel}s, but only a single ProxyToServerConnection object is used per server. The one exception to this is
 * CONNECT tunneling - if a connection has been used for CONNECT tunneling, that connection will never be reused.
 * </p>
 *
 * <p>
 * As the ProxyToServerConnections receive responses from their servers, they feed these back to the client by calling
 * {@link #respond(ProxyToServerConnection, HttpFiltersAdapter, HttpRequest, HttpResponse, HttpObject)} .
 * </p>
 */
public class ClientToProxyConnection extends ProxyConnection<HttpRequest> {
    private static final HttpResponseStatus CONNECTION_ESTABLISHED =
        new HttpResponseStatus(200, "Connection established");
    private static final String LOWERCASE_TRANSFER_ENCODING_HEADER =
        HttpHeaderNames.TRANSFER_ENCODING.toString().toLowerCase(Locale.US);
    private static final Pattern HTTP_SCHEME = Pattern.compile("^http://.*", Pattern.CASE_INSENSITIVE);

    /**
     * Keep track of all ProxyToServerConnections by host+port.
     */
    private final Map<String, ProxyToServerConnection> oneToOneServerConnectionsByHostAndPort =
            new ConcurrentHashMap<>();

    private final Map<String, ProxyToServerConnection> oneToManyServerConnectionsByHostAndPort =
            new ConcurrentHashMap<>();

    private final GlobalTrafficShapingHandler globalTrafficShapingHandler;

    private final InetSocketAddress proxyListenAddress;

    /**
     * This is the current server connection that we're using while transferring chunked data.
     */
    private volatile List<ProxyToServerConnection> currentServerConnectionList;

    /**
     * Back up one to many {@link ProxyToServerConnection} response
     */
    private volatile List<Pair<String, String>> httpResponsePairList;

    /**
     * Back up request one to many request
     */
    private volatile List<HttpRequest> currentRequestList;

    /**
     * filter
     */
    private volatile HttpFiltersAdapter currentFilters;
    /**
     * The current HTTP request that this connection is currently servicing.
     */
    private volatile HttpRequest currentRequest;

    public ClientToProxyConnection(final HttpProxyServer proxyServer, ChannelPipeline pipeline,
                                   GlobalTrafficShapingHandler globalTrafficShapingHandler) {
        super(AWAITING_INITIAL, proxyServer);
        initChannelPipeline(pipeline);
        this.globalTrafficShapingHandler = globalTrafficShapingHandler;
        this.proxyListenAddress = proxyServer.getListenAddress();
        LOG.debug("Created ClientToProxyConnection");
    }

    /***************************************************************************
     * Reading
     **************************************************************************/
    @Override
    public ConnectionState readHTTPInitial(HttpRequest httpRequest) {
        LOG.debug("Received raw request: {}", httpRequest);
        if (httpRequest.decoderResult().isFailure()) {
            LOG.debug("Could not parse request from client. Decoder result: {}",
                httpRequest.decoderResult().toString());
            FullHttpResponse response = ProxyUtils.createFullHttpResponse(HttpVersion.HTTP_1_1,
                HttpResponseStatus.BAD_REQUEST, "Unable to parse HTTP request");
            HttpUtil.setKeepAlive(response, false);
            respondWithShortCircuitResponse(response);
            return DISCONNECT_REQUESTED;
        }
        if (("/favicon.ico").equals(httpRequest.uri())) {
            return DISCONNECT_REQUESTED;
        }
        if (("/").equals(httpRequest.uri())) {
            return DISCONNECT_REQUESTED;
        }
        return doReadHTTPInitial(httpRequest);

    }

    /**
     * <p>
     * Reads an {@link HttpRequest}.
     * </p>
     *
     * <p>
     * If we don't yet have a {@link ProxyToServerConnection} for the desired server, this takes care of creating it.
     * </p>
     *
     * <p>
     * Note - the "server" could be a chained proxy, not the final endpoint for the request.
     * </p>
     *
     * @param httpRequest
     * @return
     */
    private ConnectionState doReadHTTPInitial(HttpRequest httpRequest) {
        this.releaseAndInitCurrentRequestResource();
        // Make a copy of the original request
        this.currentRequest = copy(httpRequest);
        currentFilters = proxyServer.getFiltersSource().filterRequest(currentRequest, ctx);
        HttpResponse clientToProxyFilterResponse = currentFilters.clientToProxyRequest(httpRequest);
        if (clientToProxyFilterResponse != null) {
            LOG.debug("Responding to client with short-circuit response from filter: {}", clientToProxyFilterResponse);
            boolean keepAlive = respondWithShortCircuitResponse(clientToProxyFilterResponse);
            if (keepAlive) {
                return AWAITING_INITIAL;
            } else {
                return DISCONNECT_REQUESTED;
            }
        }
        if (!proxyServer.isAllowRequestsToOriginServer() && isRequestToOriginServer(httpRequest)) {
            boolean keepAlive = writeBadRequest(httpRequest);
            if (keepAlive) {
                return AWAITING_INITIAL;
            } else {
                return DISCONNECT_REQUESTED;
            }
        }
        String serverHostAndPort = identifyHostAndPort(httpRequest);
        LOG.debug("Ensuring that hostAndPort are available in {}", httpRequest.uri());
        if (serverHostAndPort == null || StringUtils.isBlank(serverHostAndPort)
            || NetworkUtil.equalAddress(this.proxyListenAddress, serverHostAndPort)) {
            LOG.warn("No host and port found in {}", httpRequest.uri());
            boolean keepAlive = writeBadGateway(httpRequest);
            if (keepAlive) {
                return AWAITING_INITIAL;
            } else {
                return DISCONNECT_REQUESTED;
            }
        }
        try {
            List<Pair<String, HttpRequest>> splitRequests = currentFilters.splitRequest(serverHostAndPort, httpRequest);
            for (Pair<String, HttpRequest> requestPair : splitRequests) {
                currentRequestList.add(requestPair.getValue());
            }
            boolean success = true;
            for (Pair<String, HttpRequest> requestPair : splitRequests) {
                if (StringUtils.isBlank(requestPair.getKey())) {
                    continue;
                }
                if (doReadHTTPInitialInternal(requestPair.getValue(), requestPair.getKey()) == DISCONNECT_REQUESTED) {
                    success = false;
                    break;
                }
            }
            if (success) {
                return AWAITING_INITIAL;
            } else {
                String cause = "One to Many request,there is one server can not connection,request is :" + splitRequests;
                LOG.error(cause);
                writeBadGateway(httpRequest);
                return DISCONNECT_REQUESTED;
            }
        } catch (Throwable e) {
            return DISCONNECT_REQUESTED;
        }
    }

    private ConnectionState doReadHTTPInitialInternal(HttpRequest httpRequest, String serverHostAndPort) {
        LOG.debug("Finding ProxyToServerConnection for: {}", serverHostAndPort);
        ProxyToServerConnection currentServerConnection;
        if (!isOneToMany()) {
            currentServerConnection = isTunneling() ? currentServerConnectionList.get(0)
                : this.oneToOneServerConnectionsByHostAndPort.get(serverHostAndPort);
        } else {
            currentServerConnection =
                this.oneToManyServerConnectionsByHostAndPort.get(serverHostAndPort + httpRequest.uri());
        }
        boolean newConnectionRequired = false;
        if (ProxyUtils.isCONNECT(httpRequest)) {
            LOG.debug("Not reusing existing ProxyToServerConnection because request is a CONNECT for: {}",
                serverHostAndPort);
            newConnectionRequired = true;
        } else if (currentServerConnection == null) {
            LOG.debug("Didn't find existing ProxyToServerConnection for: {}", serverHostAndPort);
            newConnectionRequired = true;
        }
        if (newConnectionRequired) {
            try {
                currentServerConnection = ProxyToServerConnection.create(proxyServer, this, serverHostAndPort,
                    currentFilters, httpRequest, globalTrafficShapingHandler);
                if (currentServerConnection == null) {
                    LOG.debug("Unable to create server connection, probably no chained proxies available");
                    boolean keepAlive = writeBadGateway(httpRequest);
                    if (keepAlive) {
                        return AWAITING_INITIAL;
                    } else {
                        return DISCONNECT_REQUESTED;
                    }
                }
                if (isOneToMany()) {
                    oneToManyServerConnectionsByHostAndPort.put(serverHostAndPort + httpRequest.uri(),
                        currentServerConnection);
                    currentServerConnection.setTag(httpRequest.headers().get(PluginDefinition.X_TESLA_CONVERGE_TAG));
                    httpRequest.headers().remove(PluginDefinition.X_TESLA_CONVERGE_TAG);
                } else {
                    oneToOneServerConnectionsByHostAndPort.put(serverHostAndPort, currentServerConnection);
                }
            } catch (UnknownHostException uhe) {
                LOG.info("Bad Host {}", httpRequest.uri());
                boolean keepAlive = writeBadGateway(httpRequest);
                if (keepAlive) {
                    return AWAITING_INITIAL;
                } else {
                    return DISCONNECT_REQUESTED;
                }
            }
        }
        currentServerConnectionList.add(currentServerConnection);
        modifyRequestHeadersToReflectProxying(httpRequest);
        HttpResponse proxyToServerFilterResponse = currentFilters.proxyToServerRequest(httpRequest);
        if (proxyToServerFilterResponse != null) {
            LOG.debug("Responding to client with short-circuit response from filter: {}", proxyToServerFilterResponse);

            boolean keepAlive = respondWithShortCircuitResponse(proxyToServerFilterResponse);
            if (keepAlive) {
                return AWAITING_INITIAL;
            } else {
                return DISCONNECT_REQUESTED;
            }
        }
        LOG.info("Writing request to ProxyToServerConnection, the orgin server is :{}", serverHostAndPort);
        currentServerConnection.write(httpRequest, currentFilters);
        if (ProxyUtils.isCONNECT(httpRequest)) {
            return NEGOTIATING_CONNECT;
        } else if (ProxyUtils.isChunked(httpRequest)) {
            return AWAITING_CHUNK;
        } else {
            return AWAITING_INITIAL;
        }
    }

    /**
     * Returns true if the specified request is a request to an origin server, rather than to a proxy server. If this
     * request is being MITM'd, this method always returns false. The format of requests to a proxy server are defined
     * in RFC 7230, section 5.3.2 (all other requests are considered requests to an origin server):
     *
     * <pre>
     * When making a request to a proxy, other than a CONNECT or server-wide
     * OPTIONS request (as detailed below), a client MUST send the target
     * URI in absolute-form as the request-target.
     * [...]
     * An example absolute-form of request-line would be:
     * GET http://www.example.org/pub/WWW/TheProject.html HTTP/1.1
     * To allow for transition to the absolute-form for all requests in some
     * future version of HTTP, a server MUST accept the absolute-form in
     * requests, even though HTTP/1.1 clients will only send them in
     * requests to proxies.
     * </pre>
     *
     * @param httpRequest
     *            the request to evaluate
     * @return true if the specified request is a request to an origin server, otherwise false
     */
    private boolean isRequestToOriginServer(HttpRequest httpRequest) {
        if (httpRequest.method() == HttpMethod.CONNECT) {
            return false;
        }
        String uri = httpRequest.uri();
        return !HTTP_SCHEME.matcher(uri).matches();
    }

    @Override
    public void readHTTPChunk(HttpContent chunk) {
        if (!isOneToMany()) {
            currentFilters.clientToProxyRequest(chunk);
            currentFilters.proxyToServerRequest(chunk);
            currentServerConnectionList.get(0).write(chunk);
        } else {
            throw new UnsupportedOperationException("One to Many Request not support chunk");
        }
    }

    @Override
    public void readRaw(ByteBuf buf) {
        if (!isOneToMany()) {
            currentServerConnectionList.get(0).write(buf);
        } else {
            throw new UnsupportedOperationException("One to Many Request not support raw");
        }
    }

    /***************************************************************************
     * Writing
     **************************************************************************/

    /**
     * Send a response to the client.
     *
     * @param serverConnection
     *            the ProxyToServerConnection that's responding
     * @param filters
     *            the filters to apply to the response
     * @param currentHttpRequest
     *            the HttpRequest that prompted this response
     * @param currentHttpResponse
     *            the HttpResponse corresponding to this data (when doing chunked transfers, this is the initial
     *            HttpResponse object that came in before the other chunks)
     * @param httpObject
     *            the data with which to respond
     */
    public void respond(ProxyToServerConnection serverConnection, HttpFiltersAdapter filters,
                        HttpRequest currentHttpRequest, HttpResponse currentHttpResponse, HttpObject httpObject) {
        this.currentRequest = null;
        httpObject = filters.serverToProxyResponse(httpObject);
        if (httpObject == null) {
            forceDisconnect(serverConnection);
            return;
        }

        if (httpObject instanceof HttpResponse) {
            HttpResponse httpResponse = (HttpResponse)httpObject;
            // if this HttpResponse does not have any means of signaling the end of the message body other than closing
            // the connection, convert the message to a "Transfer-Encoding: chunked" HTTP response. This avoids the need
            // to close the client connection to indicate the end of the message. (Responses to HEAD requests "must be"
            // empty.)
            if (!ProxyUtils.isHEAD(currentHttpRequest) && !ProxyUtils.isResponseSelfTerminating(httpResponse)) {
                // if this is not a FullHttpResponse, duplicate the HttpResponse from the server before sending it to
                // the client. this allows us to set the Transfer-Encoding to chunked without interfering with netty's
                // handling of the response from the server. if we modify the original HttpResponse from the server,
                // netty will not generate the appropriate LastHttpContent when it detects the connection closure from
                // the server (see HttpObjectDecoder#decodeLast). (This does not apply to FullHttpResponses, for which
                // netty already generates the empty final chunk when Transfer-Encoding is chunked.)
                if (!(httpResponse instanceof FullHttpResponse)) {
                    HttpResponse duplicateResponse = ProxyUtils.duplicateHttpResponse(httpResponse);
                    // set the httpObject and httpResponse to the duplicated response, to allow all other standard
                    // processing
                    // (filtering, header modification for proxying, etc.) to be applied.
                    httpObject = httpResponse = duplicateResponse;
                }
                HttpUtil.setTransferEncodingChunked(httpResponse, true);
            }
            fixHttpVersionHeaderIfNecessary(httpResponse);
            modifyResponseHeadersToReflectProxying(httpResponse);
        }
        httpObject = filters.proxyToClientResponse(httpObject);
        if (httpObject == null) {
            forceDisconnect(serverConnection);
            return;
        }
        if (!currentServerConnectionList.contains(serverConnection)) {
            forceDisconnect(serverConnection);
            return;
        }
        closeServerConnectionsIfNecessary(serverConnection, currentHttpRequest, currentHttpResponse, httpObject);
        if (!isOneToMany()) {
            writeAndRelease(httpObject, currentHttpRequest, currentHttpResponse);
        } else {
            HttpContent serverResponse = (HttpContent)httpObject;
            String responseBody = serverResponse.content().toString(CharsetUtil.UTF_8);
            synchronized (this) {
                Pair<String, String> httpResponsePair = Pair.of(serverConnection.getTag(), responseBody);
                httpResponsePairList.add(httpResponsePair);
                if (currentRequestList.size() == httpResponsePairList.size()) {
                    httpObject = currentFilters.mergeResponse(httpResponsePairList);
                    writeAndRelease(httpObject, currentHttpRequest, currentHttpResponse);
                }
            }
        }
    }

    private void writeAndRelease(HttpObject httpObject, HttpRequest currentHttpRequest,
        HttpResponse currentHttpResponse) {
        write(httpObject);
        if (ProxyUtils.isLastChunk(httpObject)) {
            writeEmptyBuffer();
        }
        closeClientConnectionsAfterWriteIfNecessary(currentHttpRequest, currentHttpResponse, httpObject);
        this.releaseAndInitCurrentRequestResource();
    }

    /**
     * On connect of the client, start waiting for an initial {@link HttpRequest}.
     */
    @Override
    public void connected() {
        super.connected();
        become(AWAITING_INITIAL);
    }

    public void timedOut(ProxyToServerConnection serverConnection) {
        if (currentServerConnectionList == null) {
            return;
        }
        // 如果后端服务有一个超时了，则让所有的都超时
        currentServerConnectionList.forEach(currConnection -> {
            if (currConnection == serverConnection && this.lastReadTime > currConnection.lastReadTime
                && this.currentRequest != null) {
                // the idle timeout fired on the active server connection. send a timeout response to the client.
                LOG.warn("Server timed out: {}", currConnection);
                currentFilters.serverToProxyResponseTimedOut();
                writeGatewayTimeout(currentRequest);
            }
        });
    }

    @Override
    public void timedOut() {
        if (currentServerConnectionList == null) {
            return;
        }
        // 如果客户端反馈超时了，则让所有后端服务超时
        currentServerConnectionList.forEach(currConnection -> {
            if (currConnection == null || this.lastReadTime <= currConnection.lastReadTime) {
                // idle timeout fired on the client channel. if we aren't waiting on a response from a server, hang up
                super.timedOut();
            }
        });
    }

    /**
     * On disconnect of the client, disconnect all server connections.
     */
    @Override
    public void disconnected() {
        super.disconnected();
        for (ProxyToServerConnection serverConnection : oneToOneServerConnectionsByHostAndPort.values()) {
            serverConnection.disconnect();
        }
    }

    /**
     * If the {@link ProxyToServerConnection} fails to complete its connection lifecycle successfully, this method is
     * called to let us know about it.
     *
     * <p>
     * After failing to connect to the server, one of two things can happen:
     * </p>
     *
     * <ol>
     * <li>If the server was a chained proxy, we fall back to connecting to the ultimate endpoint directly.</li>
     * <li>If the server was the ultimate endpoint, we return a 502 Bad Gateway to the client.</li>
     * </ol>
     *
     * @param serverConnection
     * @param cause
     *            what caused the failure
     * @return true if we're falling back to a another chained proxy (or direct connection) and trying again
     */
    public boolean serverConnectionFailed(ProxyToServerConnection serverConnection, Throwable cause) {
        HttpRequest initialRequest = serverConnection.getInitialRequest();
        try {
            boolean retrying = serverConnection.connectionFailed(cause);
            if (retrying) {
                LOG.debug(
                    "Failed to connect to upstream server or chained proxy. Retrying connection. ", cause);
                return true;
            } else {
                LOG.debug("Connection to upstream server or chained proxy failed: {}. ",
                    serverConnection.getRemoteAddress(), cause);
                connectionFailedUnrecoverably(initialRequest, serverConnection);
                return false;
            }
        } catch (UnknownHostException uhe) {
            connectionFailedUnrecoverably(initialRequest, serverConnection);
            return false;
        }
    }

    private void connectionFailedUnrecoverably(HttpRequest initialRequest, ProxyToServerConnection serverConnection) {
        // the connection to the server failed, so disconnect the server and remove the ProxyToServerConnection from the
        // map of open server connections
        serverConnection.disconnect();
        this.oneToOneServerConnectionsByHostAndPort.remove(serverConnection.getServerHostAndPort());
        boolean keepAlive = writeBadGateway(initialRequest);
        if (keepAlive) {
            become(AWAITING_INITIAL);
        } else {
            become(DISCONNECT_REQUESTED);
        }
    }


    /***************************************************************************
     * Other Lifecycle
     **************************************************************************/

    /**
     * On disconnect of the server, track that we have one fewer connected servers and then disconnect the client if
     * necessary.
     *
     * @param serverConnection
     */
    public void serverDisconnected(ProxyToServerConnection serverConnection) {
        clearServerConnection(serverConnection);
        if (isTunneling()) {
            disconnect();
        }
    }

    @Override
    public void exceptionCaught(Throwable cause) {
        try {
            // IOExceptions are expected errors, for example when a browser is killed and aborts a connection.
            // rather than flood the logs with stack traces for these expected exceptions, we log the message at the
            // INFO level and the stack trace at the DEBUG level.
            if (cause instanceof IOException) {
                LOG.info("An IOException occurred on ClientToProxyConnection: " + cause.getMessage());
                LOG.debug("An IOException occurred on ClientToProxyConnection", cause);
            } else if (cause instanceof RejectedExecutionException) {
                LOG.info(
                    "An executor rejected a read or write operation on the ClientToProxyConnection (this is normal if the proxy is shutting down). Message: "
                        + cause.getMessage());
                LOG.debug("A RejectedExecutionException occurred on ClientToProxyConnection", cause);
            } else {
                LOG.error("Caught an exception on ClientToProxyConnection", cause);
            }
        } finally {
            disconnect();
        }
    }

    /***************************************************************************
     * Connection Management
     **************************************************************************/

    /**
     * Initialize the {@link ChannelPipeline} for the client to proxy channel. LittleProxy acts like a server here.
     * <p>
     * A {@link ChannelPipeline} invokes the read (Inbound) handlers in ascending ordering of the list and then the
     * write (Outbound) handlers in descending ordering.
     * <p>
     * Regarding the Javadoc of {@link HttpObjectAggregator} it's needed to have the {@link HttpResponseEncoder} or
     * {@link HttpRequestEncoder} before the {@link HttpObjectAggregator} in the
     * {@link ChannelPipeline}.
     *
     * @param pipeline
     */
    private void initChannelPipeline(ChannelPipeline pipeline) {
        LOG.debug("Configuring ChannelPipeline");
        pipeline.addLast("encoder", new HttpResponseEncoder());
        pipeline.addLast("decoder", new HttpRequestDecoder(proxyServer.getMaxInitialLineLength(),
            proxyServer.getMaxHeaderSize(), proxyServer.getMaxChunkSize()));
        int numberOfBytesToBuffer = proxyServer.getFiltersSource().getMaximumRequestBufferSizeInBytes();
        if (numberOfBytesToBuffer > 0) {
            aggregateContentForFiltering(pipeline, numberOfBytesToBuffer);
        }
        pipeline.addLast("idle", new IdleStateHandler(0, 0, proxyServer.getIdleConnectionTimeout()));
        pipeline.addLast("handler", this);

    }

    /**
     * This method takes care of closing client to proxy and/or proxy to server connections after finishing a write.
     */
    private void closeServerConnectionsIfNecessary(ProxyToServerConnection serverConnection,
                                                   HttpRequest currentHttpRequest, HttpResponse currentHttpResponse, HttpObject httpObject) {
        boolean closeServerConnection =
            shouldCloseServerConnection(currentHttpRequest, currentHttpResponse, httpObject);
        if (closeServerConnection) {
            LOG.debug("Closing remote connection ");
            serverConnection.disconnect();
        }
    }

    private void closeClientConnectionsAfterWriteIfNecessary(HttpRequest currentHttpRequest,
        HttpResponse currentHttpResponse, HttpObject httpObject) {
        boolean closeClientConnection =
            shouldCloseClientConnection(currentHttpRequest, currentHttpResponse, httpObject);
        if (closeClientConnection) {
            LOG.debug("Closing connection to client after writes");
            disconnect();
        }
    }

    private void forceDisconnect(ProxyToServerConnection serverConnection) {
        LOG.debug("Forcing disconnect");
        serverConnection.disconnect();
        disconnect();
    }

    /**
     * Determine whether or not the client connection should be closed.
     *
     * @param req
     * @param res
     * @param httpObject
     * @return
     */
    private boolean shouldCloseClientConnection(HttpRequest req, HttpResponse res, HttpObject httpObject) {
        if (ProxyUtils.isChunked(res)) {
            if (httpObject != null) {
                if (!ProxyUtils.isLastChunk(httpObject)) {
                    String uri = null;
                    if (req != null) {
                        uri = req.uri();
                    }
                    LOG.debug("Not closing client connection on middle chunk for {}", uri);
                    return false;
                } else {
                    LOG.debug("Handling last chunk. Using normal client connection closing rules.");
                }
            }
        }
        if (!HttpUtil.isKeepAlive(req)) {
            LOG.debug("Closing client connection since request is not keep alive: {}", req);
            return true;
        }
        LOG.debug("Not closing client connection for request: {}", req);
        return false;
    }

    /**
     * Determines if the remote connection should be closed based on the request and response pair. If the request is
     * HTTP 1.0 with no keep-alive header, for example, the connection should be closed.
     * <p>
     * This in part determines if we should close the connection. Here's the relevant section of RFC 2616:
     * <p>
     * "HTTP/1.1 defines the "close" connection option for the sender to signal that the connection will be closed after
     * completion of the response. For example,
     * <p>
     * Connection: close
     * <p>
     * in either the request or the response header fields indicates that the connection SHOULD NOT be considered
     * `persistent' (section 8.1) after the current request/response is complete."
     *
     * @param req
     *            The request.
     * @param res
     *            The response.
     * @param msg
     *            The message.
     * @return Returns true if the connection should close.
     */
    private boolean shouldCloseServerConnection(HttpRequest req, HttpResponse res, HttpObject msg) {
        if (ProxyUtils.isChunked(res)) {
            if (msg != null) {
                if (!ProxyUtils.isLastChunk(msg)) {
                    String uri = null;
                    if (req != null) {
                        uri = req.uri();
                    }
                    LOG.debug("Not closing server connection on middle chunk for {}", uri);
                    return false;
                } else {
                    LOG.debug("Handling last chunk. Using normal server connection closing rules.");
                }
            }
        }
        if (!HttpUtil.isKeepAlive(res)) {
            LOG.debug("Closing server connection since response is not keep alive: {}", res);
            return true;
        }

        LOG.debug("Not closing server connection for response: {}", res);
        return false;
    }

    /***************************************************************************
     * Request/Response Rewriting
     **************************************************************************/

    /**
     * Copy the given {@link HttpRequest} verbatim.
     *
     * @param original
     * @return
     */
    private HttpRequest copy(HttpRequest original) {
        if (original instanceof FullHttpRequest) {
            return ((FullHttpRequest)original).copy();
        } else {
            HttpRequest request = new DefaultHttpRequest(original.protocolVersion(), original.method(), original.uri());
            request.headers().set(original.headers());
            return request;
        }
    }

    /**
     * Chunked encoding is an HTTP 1.1 feature, but sometimes we get a chunked response that reports its HTTP version as
     * 1.0. In this case, we change it to 1.1.
     *
     * @param httpResponse
     */
    private void fixHttpVersionHeaderIfNecessary(HttpResponse httpResponse) {
        String te = httpResponse.headers().get(HttpHeaderNames.TRANSFER_ENCODING);
        if (AsciiString.contentEqualsIgnoreCase(HttpHeaderValues.CHUNKED, te)) {
            if (httpResponse.protocolVersion() != HttpVersion.HTTP_1_1) {
                LOG.debug("Fixing HTTP version.");
                httpResponse.setProtocolVersion(HttpVersion.HTTP_1_1);
            }
        }
    }

    /**
     * If and only if our proxy is not running in transparent mode, modify the request headers to reflect that it was
     * proxied.
     *
     * @param httpRequest
     */
    private void modifyRequestHeadersToReflectProxying(HttpRequest httpRequest) {
        // Remove sdch from encodings we accept since we can't decode it.
        LOG.debug("Modifying request headers for proxying");
        HttpHeaders headers = httpRequest.headers();
        ProxyUtils.removeSdchEncoding(headers);
        switchProxyConnectionHeader(headers);
        stripConnectionTokens(headers);
        stripHopByHopHeaders(headers);
        ProxyUtils.addVia(httpRequest, proxyServer.getProxyAlias());
    }

    /**
     * If and only if our proxy is not running in transparent mode, modify the response headers to reflect that it was
     * proxied.
     *
     * @param httpResponse
     * @return
     */
    private void modifyResponseHeadersToReflectProxying(HttpResponse httpResponse) {
        if (!proxyServer.isTransparent()) {
            HttpHeaders headers = httpResponse.headers();
            stripConnectionTokens(headers);
            stripHopByHopHeaders(headers);
            ProxyUtils.addVia(httpResponse, proxyServer.getProxyAlias());
            /*
             * RFC2616 Section 14.18
             *
             * A received message that does not have a Date header field MUST be
             * assigned one by the recipient if the message will be cached by
             * that recipient or gatewayed via a protocol which requires a Date.
             */
            if (!headers.contains(HttpHeaderNames.DATE)) {
                headers.set(HttpHeaderNames.DATE, new Date());
            }
        }
    }

    /**
     * Switch the de-facto standard "Proxy-Connection" header to "Connection" when we pass it along to the remote host.
     * This is largely undocumented but seems to be what most browsers and servers expect.
     *
     * @param headers
     *            The headers to modify
     */
    private void switchProxyConnectionHeader(HttpHeaders headers) {
        String proxyConnectionKey = "Proxy-Connection";
        if (headers.contains(proxyConnectionKey)) {
            String header = headers.get(proxyConnectionKey);
            headers.remove(proxyConnectionKey);
            headers.set(HttpHeaderNames.CONNECTION, header);
        }
    }

    /**
     * RFC2616 Section 14.10
     * <p>
     * HTTP/1.1 proxies MUST parse the Connection header field before a message is forwarded and, for each
     * connection-token in this field, remove any header field(s) from the message with the same name as the
     * connection-token.
     *
     * @param headers
     *            The headers to modify
     */
    private void stripConnectionTokens(HttpHeaders headers) {
        if (headers.contains(HttpHeaderNames.CONNECTION)) {
            for (String headerValue : headers.getAll(HttpHeaderNames.CONNECTION)) {
                for (String connectionToken : ProxyUtils.splitCommaSeparatedHeaderValues(headerValue)) {
                    if (!LOWERCASE_TRANSFER_ENCODING_HEADER.equals(connectionToken.toLowerCase(Locale.US))) {
                        headers.remove(connectionToken);
                    }
                }
            }
        }
    }

    /**
     * Removes all headers that should not be forwarded. See RFC 2616 13.5.1 End-to-end and Hop-by-hop Headers.
     *
     * @param headers
     *            The headers to modify
     */
    private void stripHopByHopHeaders(HttpHeaders headers) {
        Set<String> headerNames = headers.names();
        for (String headerName : headerNames) {
            if (ProxyUtils.shouldRemoveHopByHopHeader(headerName)) {
                headers.remove(headerName);
            }
        }
    }

    /***************************************************************************
     * Miscellaneous
     **************************************************************************/

    /**
     * Tells the client that something went wrong trying to proxy its request. If the Bad Gateway is a response to an
     * HTTP HEAD request, the response will contain no body, but the Content-Length header will be set to the value it
     * would have been if this 502 Bad Gateway were in response to a GET.
     *
     * @param httpRequest
     *            the HttpRequest that is resulting in the Bad Gateway response
     * @return true if the connection will be kept open, or false if it will be disconnected
     */
    private boolean writeBadGateway(HttpRequest httpRequest) {
        String body = "Bad Gateway: " + httpRequest.uri();
        FullHttpResponse response =
            ProxyUtils.createFullHttpResponse(HttpVersion.HTTP_1_1, HttpResponseStatus.BAD_GATEWAY, body);
        if (ProxyUtils.isHEAD(httpRequest)) {
            response.content().clear();
        }
        return respondWithShortCircuitResponse(response);
    }

    /**
     * Tells the client that the request was malformed or erroneous. If the Bad Request is a response to an HTTP HEAD
     * request, the response will contain no body, but the Content-Length header will be set to the value it would have
     * been if this Bad Request were in response to a GET.
     *
     * @return true if the connection will be kept open, or false if it will be disconnected
     */
    private boolean writeBadRequest(HttpRequest httpRequest) {
        String body = "Bad Request to URI: " + httpRequest.uri();
        FullHttpResponse response =
            ProxyUtils.createFullHttpResponse(HttpVersion.HTTP_1_1, HttpResponseStatus.BAD_REQUEST, body);
        if (ProxyUtils.isHEAD(httpRequest)) {
            response.content().clear();
        }
        return respondWithShortCircuitResponse(response);
    }

    /**
     * Tells the client that the connection to the server, or possibly to some intermediary service (such as DNS), timed
     * out. If the Gateway Timeout is a response to an HTTP HEAD request, the response will contain no body, but the
     * Content-Length header will be set to the value it would have been if this 504 Gateway Timeout were in response to
     * a GET.
     *
     * @param httpRequest
     *            the HttpRequest that is resulting in the Gateway Timeout response
     * @return true if the connection will be kept open, or false if it will be disconnected
     */
    private boolean writeGatewayTimeout(HttpRequest httpRequest) {
        String body = "Gateway Timeout";
        FullHttpResponse response =
            ProxyUtils.createFullHttpResponse(HttpVersion.HTTP_1_1, HttpResponseStatus.GATEWAY_TIMEOUT, body);
        if (httpRequest != null && ProxyUtils.isHEAD(httpRequest)) {
            response.content().clear();
        }

        return respondWithShortCircuitResponse(response);
    }

    /**
     * Responds to the client with the specified "short-circuit" response. The response will be sent through the
     * {@link HttpFiltersAdapter#proxyToClientResponse(HttpObject)} filter method before writing it to the client. The
     * client will not be disconnected, unless the response includes a "Connection: close" header, or the filter returns
     * a null HttpResponse (in which case no response will be written to the client and the connection will be
     * disconnected immediately). If the response is not a Bad Gateway or Gateway Timeout response, the response's
     * headers will be modified to reflect proxying, including adding a Via header, Date header, etc.
     *
     * @param httpResponse
     *            the response to return to the client
     * @return true if the connection will be kept open, or false if it will be disconnected.
     */
    private boolean respondWithShortCircuitResponse(HttpResponse httpResponse) {
        this.currentRequest = null;
        // if HttpRequest decode fail,Do not proxy filter
        if (currentFilters != null) {
            HttpResponse filteredResponse = (HttpResponse)currentFilters.proxyToClientResponse(httpResponse);
            if (filteredResponse == null) {
                disconnect();
                return false;
            }
        }
        boolean isKeepAlive = HttpUtil.isKeepAlive(httpResponse);
        int statusCode = httpResponse.status().code();
        if (statusCode != HttpResponseStatus.BAD_GATEWAY.code()
            && statusCode != HttpResponseStatus.GATEWAY_TIMEOUT.code()) {
            modifyResponseHeadersToReflectProxying(httpResponse);
        }
        HttpUtil.setKeepAlive(httpResponse, isKeepAlive);
        write(httpResponse);
        if (ProxyUtils.isLastChunk(httpResponse)) {
            writeEmptyBuffer();
        }
        if (!HttpUtil.isKeepAlive(httpResponse)) {
            disconnect();
            return false;
        }

        return true;
    }

    /**
     * Identify the host and port for a request.
     *
     * @param httpRequest
     * @return
     */
    private String identifyHostAndPort(HttpRequest httpRequest) {
        // dynamics route by request
        String hostAndPort = ProxyUtils.parseHostAndPort(httpRequest);
        if (StringUtils.isBlank(hostAndPort)) {
            List<String> hosts = httpRequest.headers().getAll(HttpHeaderNames.HOST);
            if (hosts != null && !hosts.isEmpty()) {
                hostAndPort = hosts.get(0);
            }
        }
        return hostAndPort;
    }

    /**
     * Write an empty buffer at the end of a chunked transfer. We need to do this to handle the way Netty creates
     * HttpChunks from responses that aren't in fact chunked from the remote server using Transfer-Encoding: chunked.
     * Netty turns these into pseudo-chunked responses in cases where the response would otherwise fill up too much
     * memory or where the length of the response body is unknown. This is handy because it means we can start streaming
     * response bodies back to the client without reading the entire response. The problem is that in these pseudo-cases
     * the last chunk is encoded to null, and this thwarts normal ChannelFutures from propagating operationComplete
     * events on writes to appropriate channel listeners. We work around this by writing an empty buffer in those cases
     * and using the empty buffer's future instead to handle any operations we need to when responses are fully written
     * back to clients.
     */
    private void writeEmptyBuffer() {
        write(Unpooled.EMPTY_BUFFER);
    }

    private boolean isOneToMany() {
        return currentRequestList != null && currentRequestList.size() > 1;
    }

    private void releaseAndInitCurrentRequestResource() {
        currentServerConnectionList = Lists.newArrayList();
        httpResponsePairList = Lists.newArrayList();
        currentRequestList = Lists.newArrayList();
    }

    private void clearServerConnection(ProxyToServerConnection proxyToServerConnection) {
        if (!CollectionUtils.isEmpty(oneToOneServerConnectionsByHostAndPort) &&
                oneToOneServerConnectionsByHostAndPort.containsKey(proxyToServerConnection.getServerHostAndPort())) {
            oneToOneServerConnectionsByHostAndPort.remove(proxyToServerConnection.getServerHostAndPort());
        }
        if (!CollectionUtils.isEmpty(oneToManyServerConnectionsByHostAndPort) &&
                oneToManyServerConnectionsByHostAndPort.containsKey(proxyToServerConnection.getServerHostAndPort())) {
            oneToManyServerConnectionsByHostAndPort.remove(proxyToServerConnection.getServerHostAndPort());
        }
    }

}

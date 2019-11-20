package io.github.tesla.gateway.netty.transmit;

public enum ConnectionState {
    /**
     * Connection attempting to connect.
     */
    CONNECTING,

    /**
     * In the middle of doing an SSL handshake.
     */
    HANDSHAKING,

    /**
     * In the process of negotiating an HTTP CONNECT from the client.
     */
    NEGOTIATING_CONNECT,

    /**
     * When forwarding a CONNECT to a chained proxy, we await the CONNECTION_OK message from the proxy.
     */
    AWAITING_CONNECT_OK,

    /**
     * Connected but waiting for proxy authentication.
     */
    AWAITING_PROXY_AUTHENTICATION,

    /**
     * Connected and awaiting initial message (e.g. HttpRequest or HttpResponse).
     */
    AWAITING_INITIAL,

    /**
     * Connected and awaiting HttpContent chunk.
     */
    AWAITING_CHUNK,

    /**
     * We've asked the client to disconnect, but it hasn't yet.
     */
    DISCONNECT_REQUESTED(),

    /**
     * Disconnected
     */
    DISCONNECTED();

    /**
     * Indicates whether this ConnectionState is no longer waiting for messages and is either in the process of
     * disconnecting or is already disconnected.
     *
     * @return true if the connection state is {@link #DISCONNECT_REQUESTED} or {@link #DISCONNECTED}, otherwise false
     */
    public boolean isDisconnectingOrDisconnected() {
        return this == DISCONNECT_REQUESTED || this == DISCONNECTED;
    }


}

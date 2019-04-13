package io.github.tesla.common.proto;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.os72.protocjar.Protoc;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.protobuf.DescriptorProtos.FileDescriptorSet;

/**
 * A utility class which facilitates invoking the protoc compiler on all proto files in a directory tree.
 */
public class ProtocInvoker {
    /** An error indicating that something went wrong while invoking protoc. */
    public class ProtocInvocationException extends Exception {
        private static final long serialVersionUID = 1L;

        private ProtocInvocationException(String message) {
            super(message);
        }

        private ProtocInvocationException(String message, Throwable cause) {
            super(message, cause);
        }
    }

    private static final Logger logger = LoggerFactory.getLogger(ProtocInvoker.class);

    private static final PathMatcher PROTO_MATCHER = FileSystems.getDefault().getPathMatcher("glob:**/*.proto");

    /** Creates a new {@link ProtocInvoker} with the supplied configuration. */
    public static ProtocInvoker forConfig(Path discoveryRootPath) {
        return new ProtocInvoker(discoveryRootPath);
    }

    /**
     * Extracts the .proto files for the well-known-types into a directory and returns a proto include path which can be
     * used to point protoc to the files.
     */
    private static Path setupWellKnownTypes() throws IOException {
        Path tmpdir = Files.createTempDirectory("polyglot-well-known-types");
        Path protoDir = Files.createDirectories(Paths.get(tmpdir.toString(), "google", "protobuf"));
        for (String file : WellKnownTypes.fileNames()) {
            Files.copy(ProtocInvoker.class.getResourceAsStream("/google/protobuf/" + file),
                Paths.get(protoDir.toString(), file));
        }
        return tmpdir;
    }

    private final Path discoveryRoot;

    /**
     * Takes an optional path to pass to protoc as --proto_path. Uses the invocation-time proto root if none is passed.
     */
    private ProtocInvoker(Path discoveryRoot) {
        this.discoveryRoot = discoveryRoot;
    }

    private ImmutableList<String> includePathArgs(Path wellKnownTypesInclude) {
        ImmutableList.Builder<String> resultBuilder = ImmutableList.builder();
        // Add the include path which makes sure that protoc finds the well known types. Note that we
        // add this *after* the user types above in case users want to provide their own well known
        // types.
        resultBuilder.add("-I" + wellKnownTypesInclude.toString());

        // Protoc requires that all files being compiled are present in the subtree rooted at one of
        // the import paths (or the proto_root argument, which we don't use). Therefore, the safest
        // thing to do is to add the discovery path itself as the *last* include.
        resultBuilder.add("-I" + discoveryRoot.toAbsolutePath().toString());

        return resultBuilder.build();
    }

    /**
     * Executes protoc on all .proto files in the subtree rooted at the supplied path and returns a
     * {@link FileDescriptorSet} which describes all the protos.
     */
    public FileDescriptorSet invoke() throws ProtocInvocationException {
        Path wellKnownTypesInclude;
        try {
            wellKnownTypesInclude = setupWellKnownTypes();
        } catch (IOException e) {
            throw new ProtocInvocationException("Unable to extract well known types", e);
        }

        Path descriptorPath;
        try {
            descriptorPath = Files.createTempFile("descriptor", ".pb.bin");
        } catch (IOException e) {
            throw new ProtocInvocationException("Unable to create temporary file", e);
        }

        ImmutableList<String> protocArgs = ImmutableList.<String>builder().addAll(scanProtoFiles(discoveryRoot))
            .addAll(includePathArgs(wellKnownTypesInclude))
            .add("--descriptor_set_out=" + descriptorPath.toAbsolutePath().toString()).add("--include_imports").build();

        invokeBinary(protocArgs);

        try {
            return FileDescriptorSet.parseFrom(Files.readAllBytes(descriptorPath));
        } catch (IOException e) {
            throw new ProtocInvocationException("Unable to parse the generated descriptors", e);
        }
    }

    private void invokeBinary(ImmutableList<String> protocArgs) throws ProtocInvocationException {
        int status;
        String[] protocLogLines;

        // The "protoc" library unconditionally writes to stdout. So, we replace stdout right before
        // calling into the library in order to gather its output.
        PrintStream stdoutBackup = System.out;
        try {
            ByteArrayOutputStream protocStdout = new ByteArrayOutputStream();
            System.setOut(new PrintStream(protocStdout));

            status = Protoc.runProtoc(protocArgs.toArray(new String[0]));
            protocLogLines = protocStdout.toString().split("\n");
        } catch (IOException | InterruptedException e) {
            throw new ProtocInvocationException("Unable to execute protoc binary", e);
        } finally {
            // Restore stdout.
            System.setOut(stdoutBackup);
        }
        if (status != 0) {
            // If protoc failed, we dump its output as a warning.
            logger.warn("Protoc invocation failed with status: " + status);
            for (String line : protocLogLines) {
                logger.warn("[Protoc log] " + line);
            }

            throw new ProtocInvocationException(
                String.format("Got exit code [%d] from protoc with args [%s]", status, protocArgs));
        }
    }

    private ImmutableSet<String> scanProtoFiles(Path protoRoot) throws ProtocInvocationException {
        try (final Stream<Path> protoPaths = Files.walk(protoRoot)) {
            return ImmutableSet.copyOf(protoPaths.filter(path -> PROTO_MATCHER.matches(path))
                .map(path -> path.toAbsolutePath().toString()).collect(Collectors.toSet()));
        } catch (IOException e) {
            throw new ProtocInvocationException("Unable to scan proto tree for files", e);
        }
    }
}
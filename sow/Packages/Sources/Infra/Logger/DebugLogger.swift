public final class DebugLogger {
    public static func print(_ message: String) {
        #if DEBUG || LOCAL
            Swift.print(message)
        #endif
    }
}

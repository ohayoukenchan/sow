public enum APIServiceError: Error {
    case responseError(Error)
    case parseError(Error)
}

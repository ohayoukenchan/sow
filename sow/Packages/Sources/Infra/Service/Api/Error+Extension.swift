import Foundation

public extension Error {
    var primaryError: ApiError? {
        switch self as Error {
        case let APIServiceError.responseError(errorResponse as ApiErrorResponse):
            errorResponse.errors.first
        default:
            nil
        }
    }
}

import Foundation

public extension Error {
    var primaryError: ApiError? {
        switch self as Error {
        case APIServiceError.responseError(let errorResponse as ApiErrorResponse):
            return errorResponse.errors.first
        default:
            return nil
        }
    }
}

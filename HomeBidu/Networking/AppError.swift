import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unkownError
    case invaliUrl
    case serverError(String)

    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unkownError:
            return "have no idea what go on"
        case .invaliUrl:
            return " Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}

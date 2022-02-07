import Foundation

enum Route {
    static let BaseUrl = "https:/"
    case apiStaging
    var object: String {
        switch self {
        case .apiStaging:
            return "/api-Staging.bidu.com.vn"
        }
    }
}
enum Version {
    case v1
    var version: String {
        switch self {
        case .v1:
            return "/v1"
        }
    }
}
enum Description {
    case list
    var description: String {
        switch self {
        case .list:
            return "/post/list-post"
        }
    }
}

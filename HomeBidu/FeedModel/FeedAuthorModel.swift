import UIKit

struct FeedAuthorModel: Codable {
    var _id: String
    var avatar: String
    var userName: String
    var isVerified: Bool
    var accountLevel: Int
    var hasNewStory: Bool?
}


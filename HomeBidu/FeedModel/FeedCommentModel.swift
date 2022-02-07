import UIKit

struct FeedCommentModel: Codable {
    var _id: String?
    var isEdited: Bool?
    var likeCount: Int?
    var replyCount: Int?
    var depth: Int?
    var mentions: [FeedMentionModel]
    var userCommentId: String?
    var postId: String?
    var content: String?
    var isAcitve: Bool?
    var replyTo: String?
    var createdAt: String?
    var updatedAt: String?
    var author: FeedAuthorModel?
}

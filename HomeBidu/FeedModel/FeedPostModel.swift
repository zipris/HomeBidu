import UIKit

struct FeedPostModel: Codable {
    var _id: String
    var comments: [FeedCommentModel]
    var content: String?
    var userPostId: String
    var author: FeedAuthorModel
    var categoryId: [FeedCategoryIdModel]
    var isActive: Bool
    var createdAt: String
    var updatedAt: String
    var postType: String
    var urlVideo: String?
    var fileVideo: FeedFileModel?
    var fileImage: [FeedFileModel]?
    var numberOfComments: Int
    var shareCount: Int
    var likeCount: Int
    var linkShare: String
    var viewCount: Int
    var mentions: [FeedMentionModel]
    var bodyTypeIds: [FeedBodyTypeIdModel]
    var fileBBook: FeedFileModel?
    var shorten_link : String
    var isLike: Bool
    var isFollow: Bool
    var isBookmark: Bool
}


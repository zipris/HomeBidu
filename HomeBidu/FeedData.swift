import Foundation
import UIKit

struct FeedData: Codable {
  var _id: String
  var comments: [Comments]
  var content: String?
  var userPostId: String
  var author: Author
  var categoryId: [CategoryId]
  var isActive: Bool
  var createdAt: String
  var updatedAt: String
  var postType: String
  var urlVideo: String?
  var fileVideo: File?
  var fileImage: [File]?
  var numberOfComments: Int
  var shareCount: Int
  var likeCount: Int
  var linkShare: String
  var viewCount: Int
  var mentions: [Mentions]
  var bodyTypeIds: [BodyTypeIds]
  var fileBBook: File?
  var shorten_link : String
  var isLike: Bool
  var isFollow: Bool
  var isBookmark: Bool
}

struct Author: Codable {
  var _id: String
  var avatar: String
  var userName: String
  var isVerified: Bool
  var accountLevel: Int
  var hasNewStory: Bool?
}

struct File: Codable {
  var _id: String
  var products: [String]?
  var dimensions: Size
  var thumbnail: String
  var order: Int?
  var url: String?
  
}

struct Size: Codable {
  let width: Int
  let height: Int
}
struct Comments: Codable {
  var _id: String?
  var isEdited: Bool?
  var likeCount: Int?
  var replyCount: Int?
  var depth: Int?
  var mentions: [Mentions]
  var userCommentId: String?
  var postId: String?
  var content: String?
  var isAcitve: Bool?
  var replyTo: String?
  var createdAt: String?
  var updatedAt: String?
  var author: Author?
}
struct CategoryId: Codable {
  var _id: String?
  var categoryName: String?
}
struct Mentions: Codable {
  var _id:  String?
  var userName: String?
}
struct BodyTypeIds: Codable {
  var _id: String?
  var bodyTypeName: String?
}


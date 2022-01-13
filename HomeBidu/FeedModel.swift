import Foundation
import UIKit
struct FeedModel: Codable {
  let success: Bool
  let message: String
  var data: [FeedData]
}
struct FeedData: Codable {
  let _id: String
  let comments: [Comments]
  let content: String?
  let userPostId: String
  let author: Author
  let categoryId: [CategoryId]
  let isActive: Bool
  let createdAt: String
  let updatedAt: String
  let postType: String
  let urlVideo: String?
  let fileVideo: File?
  let fileImage: [File]?
  let numberOfComments: Int
  let shareCount: Int
  let likeCount: Int
  let linkShare: String
  let viewCount: Int
  let mentions: [Mentions]
  let bodyTypeIds: [BodyTypeIds]
  let fileBBook: File?
  let shorten_link : String
  let isLike: Bool
  let isFollow: Bool
  let isBookmark: Bool
}

struct Author: Codable {
  let _id: String
  let avatar: String
  var userName: String
  let isVerified: Bool
  let accountLevel: Int
  let hasNewStory: Bool?
}

struct File: Codable {
  let _id: String
  let products: [String]?
  let dimensions: Size
  let thumbnail: String
  let order: Int?
  let url: String?

}

struct Size: Codable {
  let width: Int
  let height: Int
}
struct Comments: Codable {
  let _id: String?
  let isEdited: Bool?
  let likeCount: Int?
  let replyCount: Int?
  let depth: Int?
  let mentions: [Mentions]
  let userCommentId: String?
  let postId: String?
  let content: String?
  let isAcitve: Bool?
  let replyTo: String?
  let createdAt: String?
  let updatedAt: String?
  let author: Author?
}
struct CategoryId: Codable {
  let _id: String?
  let categoryName: String?
}
struct Mentions: Codable {
  let _id:  String?
  let userName: String?
}
struct BodyTypeIds: Codable {
  let _id: String?
  let bodyTypeName: String?
}

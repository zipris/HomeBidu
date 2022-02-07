import UIKit

struct FeedFileModel: Codable {
    var _id: String
    var products: [String]?
    var dimensions: FeedSizeModel
    var thumbnail: String
    var order: Int?
    var url: String?
}

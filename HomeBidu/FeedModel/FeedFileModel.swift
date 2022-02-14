import UIKit

struct FeedFileModel: Codable {
    var _id: String
    var products: [FeedProductModel]?
    var dimensions: FeedSizeModel
    var thumbnail: String
    var order: Int?
    var url: String?
}

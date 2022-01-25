import Foundation
struct ApiResponse<T: Codable>: Codable {
  let success: Bool
  let message: String?
  var data: T?
  let error: String?
}

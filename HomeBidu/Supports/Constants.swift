import Foundation

let sizeIphone = 0.77

struct Identifier {
  static let homeIdentifier = "HomeCollectionCell"
  static let tableIdentifier = "HomeTableCell"
}
struct Url {
  static let url = "https://api-staging.bidu.com.vn/v1/post/list-post?categoryId=ALL&page=1&sort=recent"
  static let header = [
    "x-api-key": "fashionapp.$2a$10$4Z1a2mIuS/rv6CqjGj9TSeuax2yT0s03IiX5hVAt9JrIKdkVuk8eq",
    "Accept-Language": "vi"
  ]
}
struct Image {
  static let background = "background"
  static let heart = "tim"
  static let redHeart = "timdo"
  static let avatar = "image_1"
  static let chat = "chat"
  static let save = "save"
  static let share = "share"
  static let more = "more"
  static let famous = "famous"
  static let follow = "+"
}
struct Button {
  static let shared = "Shared"
  static let save = "Saved"
  static let more = "More"
  static let follow = "Followed"
}
struct Notification {
  static let response = "Status code: "
  static let error = "Error: "
  static let available = "available data"
  static let downloading = "downloading"
  static let find = "Not Found"
  static let errorData = "Error encoding item array"
  static let fatalError = "init(coder:) has not been implemented"
}
struct Info {
  static let name = "Hồ Phương Anh"
  static let active = "12 phút trước"
  static let status = """
Trước đây mỗi buổi sáng mở mắt dậy việc đầu
tiên phải suy nghĩ "Mang gì đi làm"...Xem Thêm
"""
  static let hagtag = "#Đi làm\t#Dạo phố\t#Phong Cách\t#Quần Tây"
}
struct Font {
  static let lexendSemiBoldFont = "Lexend-SemiBold"
  static let JosefinSansRegularFont = "JosefinSans-Regular"
  static let lexendRegularFont = "Lexend-Regular"
}


import Foundation

//MARK: - Fetchable Image Options
struct FetchableImageOptions {
  var storeInCachesDirectory: Bool = true
  var allowLocalStorage: Bool = true
  var customFileName: String?
}
//MARK: - Fetchable Image Helper
struct FetchableImageHelper {
  static var documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory,
                                                              in: .userDomainMask)[0]
  static var cachesDirectoryURL = FileManager.default.urls(for: .cachesDirectory,
                                                           in: .userDomainMask)[0]
  
  static func getOptions(_ options: FetchableImageOptions?) -> FetchableImageOptions {
    return options != nil ? options! : FetchableImageOptions()
  }
  
  static func getImageName(from urlString: String) -> String? {
    guard var base64String = urlString.data(using: .utf8)?.base64EncodedString() else {
      return nil
    }
    base64String = base64String.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    
    guard base64String.count < 50 else {
      return String(base64String.dropFirst(base64String.count - 50))
    }
    return base64String
  }
  
  static func downloadImage(from url: URL, completion: @escaping (_ imageData: Data?) -> Void) {
    let sessionConfiguration = URLSessionConfiguration.ephemeral
    let session = URLSession(configuration: sessionConfiguration)
    let task = session.dataTask(with: url) { (data, response, error) in
      completion(data)
    }
    task.resume()
  }
  static func loadLocalImage(from url: URL) -> Data? {
    do {
      let imageData = try Data(contentsOf: url)
      return imageData
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
}

//MARK: - Protocol Fetchable Image
protocol FetchableImage {
  func localFileURL(for imageURL: String?, options: FetchableImageOptions?) -> URL?
  func fetchImage(from urlString: String?, options: FetchableImageOptions?,
                  completion: @escaping (_ imageData: Data?) -> Void)
  func save(image data: Data, options: FetchableImageOptions) -> Bool
  func deleteImage(using imageURL: String?,
                   options: FetchableImageOptions?) -> Bool
}

//MARK: - Extension Fetchable Image
extension FetchableImage {
  func localFileURL(for imageURL: String?, options: FetchableImageOptions? = nil) -> URL? {
    let otp = FetchableImageHelper.getOptions(options)
    let targetDir = otp.storeInCachesDirectory ?
      FetchableImageHelper.cachesDirectoryURL : FetchableImageHelper.documentsDirectoryURL
    
    guard let urlString = imageURL else {
      guard let customFileName = otp.customFileName else {
        return nil
      }
      return targetDir.appendingPathComponent(customFileName)
    }
    
    guard let imageName = FetchableImageHelper.getImageName(from: urlString) else {
      return nil
    }
    return targetDir.appendingPathComponent(imageName)
  }
  
  func fetchImage(from urlString: String?,
                  options: FetchableImageOptions? = nil,
                  completion: @escaping (_ imageData: Data?) -> Void) {
    DispatchQueue.global(qos: .background).async {
      let opt = FetchableImageHelper.getOptions(options)
      let localURL = self.localFileURL(for: urlString, options: options)
      if opt.allowLocalStorage,
         let localURL = localURL,
         FileManager.default.fileExists(atPath: localURL.path) {
        let loadedImageData = FetchableImageHelper.loadLocalImage(from: localURL)
        print(Notification.available)
        completion(loadedImageData)
      } else {
        print(Notification.downloading)
        guard let urlString = urlString, let url = URL(string: urlString) else {
          completion(nil)
          return
        }
        
        FetchableImageHelper.downloadImage(from: url) { (imageData) in
          if opt.allowLocalStorage,
             let localURL = localURL {
            try? imageData?.write(to: localURL)
          }
          completion(imageData)
        }
      }
    }
  }
  
  func deleteImage(using imageURL: String?, options: FetchableImageOptions? = nil) -> Bool {
    guard let localURL = localFileURL(for: imageURL,options: options),
          FileManager.default.fileExists(atPath: localURL.path) else {
      return false
    }
    do {
      try FileManager.default.removeItem(at: localURL)
      return true
    } catch {
      print(error.localizedDescription)
      return false
    }
  }
  
  func save(image data: Data, options: FetchableImageOptions) -> Bool {
    guard let url = localFileURL(for: nil, options: options) else {
      return false
    }
    do {
      try data.write(to: url)
      return true
    } catch {
      print(error.localizedDescription)
      return false
    }
  }
}


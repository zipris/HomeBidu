import Foundation

//MARK: - FetchableImageOptions
struct FetchableImageOptions {
    var storeInCachesDirectory: Bool = true
    var allowLocalStorage: Bool = true
    var customFileName: String?
}
//MARK: - FetchableImageHelper
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

//MARK: - FetchableImage
protocol FetchableImage {
    func fetchImage(from urlString: String?,
                    options: FetchableImageOptions?,
                    completion: @escaping (_ imageData: Data?) -> Void)
    
    func localFileURL(for imageURL: String?,
                      options: FetchableImageOptions?) -> URL?
}

//MARK: - fetchImage
extension FetchableImage {
    public func fetchImage(from urlString: String?,
                           options: FetchableImageOptions? = nil,
                           completion: @escaping (_ imageData: Data?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let opt = FetchableImageHelper.getOptions(options)
            let localURL = self.localFileURL(for: urlString, options: options)
            if opt.allowLocalStorage,
               let localURL = localURL,
               FileManager.default.fileExists(atPath: localURL.path) {
                let loadedImageData = FetchableImageHelper.loadLocalImage(from: localURL)
                print("Available")
                completion(loadedImageData)
            } else {
                print("Downloading")
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
    
    public func localFileURL(for imageURL: String?,
                             options: FetchableImageOptions? = nil) -> URL? {
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
}

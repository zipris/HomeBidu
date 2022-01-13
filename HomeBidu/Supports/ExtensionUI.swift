import UIKit

//MARK: - Insert View
public extension UIView {
  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
}

//MARK: - Protocol And Extension Basic Cell
protocol BaseCellProtocol {
  static func getNibName() -> String
  static func getNib() -> UINib
}

extension BaseCellProtocol where Self : UIView {
  static func getNibName() -> String {
    return String(describing: self)
  }
  
  static func getNib() -> UINib {
    return UINib.init(nibName: self.getNibName(), bundle: nil)
  }
}

//MARK: - Download Image from URL
public class ImageLoader {
  private var loadedImages = [URL: UIImage]()
  private var runningRequests = [UUID: URLSessionDataTask]()
  func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
    if let image = loadedImages[url] {
      completion(.success(image))
      return nil
    }
    let uuid = UUID()
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      defer {self.runningRequests.removeValue(forKey: uuid) }
      if let data = data, let image = UIImage(data: data) {
        self.loadedImages[url] = image
        completion(.success(image))
        return
      }
      guard let error = error else {
        return
      }
      guard (error as NSError).code == NSURLErrorCancelled else {
        completion(.failure(error))
        return
      }
    }
    task.resume()
    runningRequests[uuid] = task
    return uuid
  }
  func cancelLoad(_ uuid: UUID) {
    runningRequests[uuid]?.cancel()
    runningRequests.removeValue(forKey: uuid)
  }
}
//MARK: - Memory cache for loaded images
public class UIImageLoader {
  static let loader = UIImageLoader()
  private let imageLoader = ImageLoader()
  private var uuidMap = [UIImageView: UUID]()
  private init() {}
  func load(_ url: URL, for imageView: UIImageView) {
    let token = imageLoader.loadImage(url) { result in
      defer { self.uuidMap.removeValue(forKey: imageView) }
      do {
        let image = try result.get()
        DispatchQueue.main.async {
          imageView.image = image
        }
      } catch {}
    }
    if let token = token {
      uuidMap[imageView] = token
    }
  }

  func cancel(for imageView: UIImageView) {
    if let uuid = uuidMap[imageView] {
      imageLoader.cancelLoad(uuid)
      uuidMap.removeValue(forKey: imageView)
    }
  }
}
extension UIImageView {
  func loadImage(at url: URL) {
      UIImageLoader.loader.load(url, for: self)
    }
    func cancelImageLoad() {
      UIImageLoader.loader.cancel(for: self)
    }
  
}

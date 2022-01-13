import Foundation

class ApiService {
  private var dataTask: URLSessionDataTask?
  private var images = NSCache<NSString, NSData>()
  func getFeedHomeData(onCompletion: @escaping (Result<[FeedData], Error>) -> Void) {
    let feedURL = Url.url
    guard let url = URL(string: feedURL) else {return}
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = Url.header
    dataTask = URLSession.shared.dataTask(with: request) { (data, resquonse, error) in
      if let error = error {
        onCompletion(.failure(error))
        print(error.localizedDescription)
      }
      guard let response = resquonse as? HTTPURLResponse else {return}
      print(response.statusCode)
      guard let data = data else {return}
      do {
        let jsonData = try JSONDecoder().decode(FeedModel.self, from: data)
        let dataRespone = jsonData.data
        onCompletion(.success(dataRespone))
      } catch let error {
        onCompletion(.failure(error))
      }
    }
    dataTask?.resume()
  }
}

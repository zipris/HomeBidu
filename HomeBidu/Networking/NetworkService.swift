import Foundation
import Network

struct NetWorkService {
    static let shared = NetWorkService()
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Internet Connection Monitor")

    private init() {}
}
//MARK: - feedDataRequest
extension NetWorkService {
    func feedDataRequest(completion: @escaping(Result<[FeedPostModel], Error>) -> Void) {
        request(route: .apiStaging,
                version: .v1,
                description: .list,
                method: .get,
                parameters: ["categoryId": "ALL",
                             "page": "1",
                             "sort" : "recent"],
                completion: completion)
    }
}
//MARK: - request
extension NetWorkService: FetchableImage {
    private func request<T: Codable>(route: Route,
                                     version: Version,
                                     description: Description,
                                     method: Method,
                                     parameters: [String: Any]? = nil,
                                     completion: @escaping(Result<T, Error>) -> Void) {
        // Check connection -> call data
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection")
                guard let request = createRequest(route: route,
                                                  version: version,
                                                  description: description,
                                                  method: method,
                                                  parameters: parameters)
                else {
                    completion(.failure(AppError.unkownError))
                    return
                }
                URLSession.shared.dataTask(with: request) { data, response, error in
                    var result: Result<Data, Error>?
                    if let data = data {
                        result = .success(data)
                    } else if let error = error {
                        result = .failure(error)
                        print(error.localizedDescription)
                    }
                    DispatchQueue.main.async {
                        self.handleResponse(result: result, completion: completion)
                    }
                }.resume()
            } else {
                print("No internet connection.")
            }
        }
        monitor.start(queue: queue)
    }
}

//MARK: - handleResponse
extension NetWorkService {
    private func handleResponse<T: Codable> (result: Result<Data, Error>?,
                                             completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unkownError))
            return
        }
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }

            if let decodedData = response.data {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.unkownError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

//MARK: - createRequest
/// This function helps us to generate a urlRequest
/// - Parameters:
///   - route: the path the the resource in the backend
///   - method: type of request to be made
///   - parameters: whatever extra information you need to pass to the backend
/// - Returns: URLRequest
extension NetWorkService {
    private func createRequest(route: Route,
                               version: Version,
                               description: Description,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.BaseUrl + route.object + version.version + description.description
        guard let url = URL(string: urlString) else {return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = Helper.HeaderFeed
        urlRequest.httpMethod = method.rawValue

        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}

import Foundation

enum NetworkError: Error {
    case invalidURLRequest
    case jsonDecodingError(Error)
}

final class URLSessionNetworkClient: NetworkClient {
  private let session = URLSession.shared
  
  func request<T: Decodable>(_ convertible: URLRequestConvertible,
                             notifyOn queue: DispatchQueue,
                             decoder: JSONDecoder,
                             completion: ((Result<T, Error>) -> Void)?) {
    guard let urlRequest = try? convertible.asURLRequest() else {
      completion?(.failure(NetworkError.invalidURLRequest))
      return
    }
    let task = session.dataTask(with: urlRequest) { data, urlResponse, error in
      func handle(_ result: Result<T, Error>) {
        queue.async {
          completion?(result)
        }
      }
      
      if let error = error {
        handle(.failure(error))
      } else if let data = data {
        do {
          let decodedData = try decoder.decode(T.self, from: data)
          handle(.success(decodedData))
        } catch {
          handle(.failure(NetworkError.jsonDecodingError(error)))
        }
      }
    }
    task.resume()
  }
}

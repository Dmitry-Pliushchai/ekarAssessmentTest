import Foundation

protocol NetworkClient: AnyObject {
  func request<T: Decodable>(_ convertible: URLRequestConvertible,
                             completion: ((Result<T, Error>) -> Void)?)
  
  func request<T: Decodable>(_ convertible: URLRequestConvertible,
                             notifyOn queue: DispatchQueue,
                             completion: ((Result<T, Error>) -> Void)?)
  
  func request<T: Decodable>(_ convertible: URLRequestConvertible,
                             notifyOn queue: DispatchQueue,
                             decoder: JSONDecoder,
                             completion: ((Result<T, Error>) -> Void)?)
}

extension NetworkClient {
  func request<T: Decodable>(_ convertible: URLRequestConvertible, completion: ((Result<T, Error>) -> Void)?) {
    request(convertible, notifyOn: .main, completion: completion)
  }
  
  func request<T: Decodable>(
    _ convertible: URLRequestConvertible,
    notifyOn queue: DispatchQueue, completion: ((Result<T, Error>) -> Void)?
  ) {
    let defaultDecoder = JSONDecoder()
    request(convertible, notifyOn: queue, decoder: defaultDecoder, completion: completion)
  }
}

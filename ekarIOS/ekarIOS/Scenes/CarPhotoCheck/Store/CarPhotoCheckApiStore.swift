import Foundation

protocol CarPhotoCheckApiStore {
  func fetchInfo(request: URLRequestConvertible, completion: @escaping (Result<CommonResponse, Error>) -> Void)
}

final class DefaultCarPhotoCheckApiStore: CarPhotoCheckApiStore {
  private let client: NetworkClient
  
  init(client: NetworkClient) {
    self.client = client
  }
  
  func fetchInfo(request: URLRequestConvertible, completion: @escaping (Result<CommonResponse, Error>) -> Void) {
    client.request(request, completion: completion)
  }
}

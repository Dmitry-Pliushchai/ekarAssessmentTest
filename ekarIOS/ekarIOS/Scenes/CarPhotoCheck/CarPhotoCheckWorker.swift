import Foundation
import CoreLocation

final class CarPhotoCheckWorker {
  private let carPhotoCheckStore: CarPhotoCheckStoreProtocol
  private let carPhotoCheckApiStore: CarPhotoCheckApiStore
  
  init(carPhotoCheckStore: CarPhotoCheckStoreProtocol, carPhotoCheckApiStore: CarPhotoCheckApiStore) {
    self.carPhotoCheckStore = carPhotoCheckStore
    self.carPhotoCheckApiStore = carPhotoCheckApiStore
  }
  
  func fetchInfo(completion: (Result<CarPhotoCheckInfo, Error>) -> Void) {
    carPhotoCheckStore.fetchInfo(completion: completion)
  }
  
  func fetchInfo(request: URLRequestConvertible, completion: @escaping (Result<CommonResponse, Error>) -> Void) {
    carPhotoCheckApiStore.fetchInfo(request: request, completion: completion)
  }
}

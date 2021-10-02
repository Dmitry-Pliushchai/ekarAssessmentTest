import Foundation

protocol CarPhotoCheckServiceFactory {
  func worker() -> CarPhotoCheckWorker
}

final class DefaultCarPhotoCheckServiceFactory: CarPhotoCheckServiceFactory {
  func worker() -> CarPhotoCheckWorker {
    CarPhotoCheckWorker(
      carPhotoCheckStore: CarPhotoCheckLocalStore(),
      carPhotoCheckApiStore: DefaultCarPhotoCheckApiStore(client: URLSessionNetworkClient())
    )
  }
}

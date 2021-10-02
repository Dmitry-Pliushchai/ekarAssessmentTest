import UIKit

protocol CarPhotoCheckRoutingLogic {}

protocol CarPhotoCheckDataPassing: AnyObject {
  var dataStore: CarPhotoCheckDataStore { get }
}

final class CarPhotoCheckRouter: CarPhotoCheckDataPassing {
  // MARK: - Dependencies
  private weak var viewController: UIViewController?
  let dataStore: CarPhotoCheckDataStore

  // MARK: - Init
  init(viewController: UIViewController, dataStore: CarPhotoCheckDataStore) {
    self.viewController = viewController
    self.dataStore = dataStore
  }
}

// MARK: - CarPhotoCheckRoutingLogic
extension CarPhotoCheckRouter: CarPhotoCheckRoutingLogic {}

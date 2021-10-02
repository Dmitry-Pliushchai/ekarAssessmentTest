import UIKit

protocol MapRoutingLogic {
  func routeToCapPhotoCheck()
}

protocol MapDataPassing: AnyObject {
  var dataStore: MapDataStore { get }
}

final class MapRouter: MapDataPassing {
  // MARK: - Dependencies
  private weak var viewController: UIViewController?
  let dataStore: MapDataStore

  // MARK: - Init
  init(viewController: UIViewController, dataStore: MapDataStore) {
    self.viewController = viewController
    self.dataStore = dataStore
  }
}

// MARK: - MapRoutingLogic
extension MapRouter: MapRoutingLogic {
  func routeToCapPhotoCheck() {
    let storyboard = UIStoryboard(name: "CarPhotoCheck", bundle: nil)
    
    guard
      let carPhotoCheckController = storyboard.instantiateViewController(
        withIdentifier: CarPhotoCheckViewController.className
      ) as? CarPhotoCheckViewController
    else { return }
    
    var destinationDataStore = carPhotoCheckController.router?.dataStore
    destinationDataStore?.coordinate = dataStore.selectedCoordinate
    
    carPhotoCheckController.modalPresentationStyle = .fullScreen
    
    viewController?.present(
      carPhotoCheckController,
      animated: true,
      completion: nil
    )
  }
}

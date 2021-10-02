import Foundation
import CoreLocation

protocol MapBusinessLogic {
  func selectCarLocation(request: Map.SelectCarLocation.Request)
}

protocol MapDataStore {
  var selectedCoordinate: CLLocationCoordinate2D? { get }
}

final class MapInteractor: MapDataStore {
  // MARK: - Dependencies
  private let presenter: MapPresentationLogic
  
  var selectedCoordinate: CLLocationCoordinate2D?
  
  // MARK: - Init
  init(presenter: MapPresentationLogic) {
    self.presenter = presenter
  }
}

// MARK: - MapBusinessLogic
extension MapInteractor: MapBusinessLogic {
  func selectCarLocation(request: Map.SelectCarLocation.Request) {
    selectedCoordinate = request.coordinate
  }
}

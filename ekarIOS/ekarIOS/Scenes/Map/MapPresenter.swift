import Foundation

protocol MapPresentationLogic {}

final class MapPresenter {
  // MARK: - Dependencies
  private weak var viewController: MapDisplayLogic?

  // MARK: - Init
  init(viewController: MapDisplayLogic) {
    self.viewController = viewController
  }
}

// MARK: - MapPresentationLogic
extension MapPresenter: MapPresentationLogic {}


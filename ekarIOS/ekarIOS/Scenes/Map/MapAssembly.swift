import Foundation

final class MapAssembly {
  // MARK: - Public
  func injectDependencies(for viewController: MapViewController) {
    let presenter = MapPresenter(viewController: viewController)
    let interactor = MapInteractor(
      presenter: presenter
    )
    let router = MapRouter(
      viewController: viewController,
      dataStore: interactor
    )
    
    viewController.interactor = interactor
    viewController.router = router
  }
}

import Foundation

final class CarPhotoCheckAssembly {
  // MARK: - Dependencies
  private let serviceFactory: CarPhotoCheckServiceFactory

  // MARK: - Init
  init(serviceFactory: CarPhotoCheckServiceFactory) {
    self.serviceFactory = serviceFactory
  }

  // MARK: - Public
  func injectDependencies(for viewController: CarPhotoCheckViewController) {
    let presenter = CarPhotoCheckPresenter(viewController: viewController)
    let interactor = CarPhotoCheckInteractor(
      presenter: presenter,
      worker: serviceFactory.worker()
    )
    let router = CarPhotoCheckRouter(
      viewController: viewController,
      dataStore: interactor
    )

    viewController.interactor = interactor
    viewController.router = router
  }
}

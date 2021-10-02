import Foundation

final class CarPhotoCheckConfigurator: NSObject {
  // must be weak to prevent retain cycle
  // swiftlint:disable:next strong_iboutlet
  @IBOutlet private weak var viewController: CarPhotoCheckViewController!
  
  override func awakeFromNib() {
    super.awakeFromNib()

    let asssembly = CarPhotoCheckAssembly(serviceFactory: DefaultCarPhotoCheckServiceFactory())
    asssembly.injectDependencies(for: viewController)
  }
}

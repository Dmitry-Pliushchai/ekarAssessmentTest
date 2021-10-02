import Foundation

final class MapConfigurator: NSObject {
  @IBOutlet private weak var viewController: MapViewController!
  
  override func awakeFromNib() {
    super.awakeFromNib()

    let asssembly = MapAssembly()
    asssembly.injectDependencies(for: viewController)
  }
}

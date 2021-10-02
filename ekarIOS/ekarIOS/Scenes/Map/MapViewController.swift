import UIKit
import MapKit

protocol MapDisplayLogic: AnyObject {}

final class MapViewController: UIViewController {
  @IBOutlet private var mapView: MKMapView!
  
  var interactor: MapBusinessLogic?
  var router: (MapRoutingLogic & MapDataPassing)?
}

// MARK: - Life Cycle
extension MapViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupMap()
  }
}

// MARK: - Private
extension MapViewController {
  private func setupUI() {
    guard let navigationController = navigationController else { return }
    
    let image = UIImage(named: MapConstants.ImageName.logo)
    let imageView = UIImageView(image: image)
    let navigationBarHeight = navigationController.navigationBar.frame.height
    
    let containerFrame = CGRect(
      x: 0,
      y: 0,
      width: view.frame.width,
      height: navigationBarHeight / 2
    )
    
    let containerView = UIView(frame: containerFrame)
    imageView.frame = containerFrame
    
    containerView.addSubview(imageView)
    imageView.contentMode = .scaleAspectFit
    
    navigationItem.titleView = containerView
  }
  
  private func setupMap() {
    mapView.delegate = self
    
    mapView.register(
      CarLocationAnnotationView.self,
      forAnnotationViewWithReuseIdentifier: MapConstants.AnnotationIdentifier.carLocation
    )
    
    let carAnnotation = CarLocationAnnotation(
      coordinate: mapView.centerCoordinate
    )
    
    mapView.addAnnotation(carAnnotation)
  }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    guard
      let carLocationAnnotationView = view as? CarLocationAnnotationView,
      let carLocationAnnotation = carLocationAnnotationView.annotation as? CarLocationAnnotation
    else { return }
    
    mapView.deselectAnnotation(carLocationAnnotation, animated: false)
    
    let request = Map.SelectCarLocation.Request(
      coordinate: carLocationAnnotation.coordinate
    )
    interactor?.selectCarLocation(request: request)
    
    router?.routeToCapPhotoCheck()
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard
      let carLocationAnnotationView = mapView.dequeueReusableAnnotationView(
        withIdentifier: MapConstants.AnnotationIdentifier.carLocation,
        for: annotation
      ) as? CarLocationAnnotationView
    else { return nil }
    
    carLocationAnnotationView.imageView.image = UIImage(
      named: MapConstants.ImageName.logo
    )
    
    carLocationAnnotationView.frame = MapConstants.Dimensions.annotationFrame
    carLocationAnnotationView.backgroundColor = .white
    
    return carLocationAnnotationView
  }
}

// MARK: - MapDisplayLogic
extension MapViewController: MapDisplayLogic { }

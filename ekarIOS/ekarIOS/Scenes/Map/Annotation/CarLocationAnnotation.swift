import Foundation
import MapKit

final class CarLocationAnnotation: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  
  init (coordinate: CLLocationCoordinate2D) {
    self.coordinate = coordinate
  }
}

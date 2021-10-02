import Foundation
import MapKit

final class CarLocationAnnotationView: MKAnnotationView {
  private (set) var imageView = UIImageView()
  
  override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    
    imageView.frame = MapConstants.Dimensions.annotationFrame
    imageView.contentMode = .scaleAspectFit
    addSubview(imageView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

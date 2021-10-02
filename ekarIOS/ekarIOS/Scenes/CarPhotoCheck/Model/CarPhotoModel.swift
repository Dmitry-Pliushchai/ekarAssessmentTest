import Foundation
import UIKit

enum CarPhotoViewType {
  case frontLeft
  case frontRight
  case backLeft
  case backRight
}

final class CarPhotoModel {
  private let id = UUID()
  var image: UIImage?
  let placeholderImage: UIImage?
  var text: String
  let viewType: CarPhotoViewType
  
  init(image: UIImage?, placeholderImage: UIImage?, text: String, viewType: CarPhotoViewType) {
    self.image = image
    self.placeholderImage = placeholderImage
    self.text = text
    self.viewType = viewType
  }
}

extension CarPhotoModel: Hashable {
  static func == (lhs: CarPhotoModel, rhs: CarPhotoModel) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

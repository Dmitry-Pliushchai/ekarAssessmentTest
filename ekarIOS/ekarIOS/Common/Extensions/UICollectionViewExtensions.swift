import Foundation
import UIKit

extension UICollectionView {
  func registerNib<T: UICollectionViewCell>(forType type: T.Type) {
    let nib = UINib(nibName: T.className, bundle: nil)
    register(nib, forCellWithReuseIdentifier: T.className)
  }
  
  func dequeueReusableCell<T>(_ type: T.Type , for indexPath: IndexPath) -> T where T: UICollectionViewCell {
    dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
  }
}

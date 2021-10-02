import UIKit

class CarPhotoCell: UICollectionViewCell {
  @IBOutlet private var imageView: UIImageView!
  @IBOutlet private var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(didTapped(_:)))
    addGestureRecognizer(tap)
  }
  
  var carPhotoSelected: ((CarPhotoViewType?) -> Void)?
  
  var item: CarPhotoModel? {
    didSet {
      imageView.image = item?.image ?? item?.placeholderImage
      titleLabel.text = item?.text
    }
  }
  
  @objc func didTapped(_ sender: Any) {
    carPhotoSelected?(item?.viewType)
  }
}

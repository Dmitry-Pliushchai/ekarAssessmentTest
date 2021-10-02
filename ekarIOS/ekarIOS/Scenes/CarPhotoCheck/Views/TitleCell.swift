import UIKit

class TitleCell: UICollectionViewCell {
  @IBOutlet private var titleLabel: UILabel!
  
  var item: TitleModel? {
    didSet {
      titleLabel.text = item?.title
    }
  }
}

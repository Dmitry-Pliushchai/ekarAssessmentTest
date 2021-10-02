import UIKit

final class CommentCell: UICollectionViewCell {
  @IBOutlet private var headerLabel: UILabel!
  @IBOutlet private var textField: UITextField!
  
  var textChangedHandler: ((String) -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    textField.delegate = self
  }
  
  var item: CommentModel? {
    didSet {
      headerLabel.text = item?.headerText
      textField.text = item?.text
      textField.placeholder = item?.placeholder
    }
  }
  
  @IBAction private func textChanged(_ sender: Any) {
    textChangedHandler?(textField.text ?? .empty)
  }
}

extension CommentCell: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.endEditing(true)
    return true
  }
}

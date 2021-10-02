import Foundation

final class CommentModel {
  private let id = UUID().uuidString
  let headerText: String
  var text: String
  let placeholder: String
  
  init(headerText: String, text: String, placeholder: String) {
    self.headerText = headerText
    self.text = text
    self.placeholder = placeholder
  }
}

extension CommentModel: Hashable {
  static func == (lhs: CommentModel, rhs: CommentModel) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

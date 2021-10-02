import Foundation

final class TitleModel {
  private let id = UUID().uuidString
  let title: String
  
  init(title: String) {
    self.title = title
  }
}

extension TitleModel: Hashable {
  static func == (lhs: TitleModel, rhs: TitleModel) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

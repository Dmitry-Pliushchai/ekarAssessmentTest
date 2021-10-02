import Foundation
import UIKit

protocol CarPhotoCheckStoreProtocol {
  func fetchInfo(completion: (Result<CarPhotoCheckInfo, Error>) -> Void)
}

final class CarPhotoCheckLocalStore: CarPhotoCheckStoreProtocol {
  func fetchInfo(completion: (Result<CarPhotoCheckInfo, Error>) -> Void) {
    completion(.success(
      CarPhotoCheckInfo(
        titleModel: TitleModel(title: "Please, upload clear photo of vehicle"),
        carPhotoModels: [
          CarPhotoModel(
            image: nil,
            placeholderImage: UIImage(named: "frontLeft"),
            text: "Front/Left".uppercased(),
            viewType: .frontLeft
          ),
          CarPhotoModel(
            image: nil,
            placeholderImage: UIImage(named: "frontRight"),
            text: "Front/Right".uppercased(),
            viewType: .frontRight
          ),
          CarPhotoModel(
            image: nil,
            placeholderImage: UIImage(named: "backLeft"),
            text: "Back/Left".uppercased(),
            viewType: .backLeft
          ),
          CarPhotoModel(
            image: nil,
            placeholderImage: UIImage(named: "backRight"),
            text: "Back/Right".uppercased(),
            viewType: .backRight
          )
        ],
        commentModel: CommentModel(
          headerText: "Leave a comment:",
          text: "",
          placeholder: "placeholder"
        )
      )
    )
    )
  }
}

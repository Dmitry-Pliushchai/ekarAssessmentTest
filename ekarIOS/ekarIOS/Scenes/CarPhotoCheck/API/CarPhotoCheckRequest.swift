import CoreLocation

struct CarPhotoCheckRequest: NetworkRequest {
  let host = "https://stoplight.io/mocks/dpliushchai/ekap/23033709"
  let path = "/carCheckInfo"
  
  let method: HTTPMethod = .post
  
  let params: HTTPParameters?
  
  init(coordinate: CLLocationCoordinate2D, carCheckInfo: CarPhotoCheckInfo) {
    params = [
      "lat": coordinate.latitude,
      "lon": coordinate.longitude,
      "fronLeftImage": carCheckInfo
        .carPhotoModels
        .first(where: { $0.viewType == .frontLeft })?
        .image?
        .jpegData(compressionQuality: .leastNonzeroMagnitude)?
        .base64EncodedString() ?? .empty,
      "fronRightImage": carCheckInfo
        .carPhotoModels
        .first(where: { $0.viewType == .frontRight })?
        .image?
        .jpegData(compressionQuality: .leastNonzeroMagnitude)?
        .base64EncodedString() ?? .empty,
      "backLeftImage": carCheckInfo
        .carPhotoModels
        .first(where: { $0.viewType == .backLeft })?
        .image?
        .jpegData(compressionQuality: .leastNonzeroMagnitude)?
        .base64EncodedString() ?? .empty,
      "backRightImage": carCheckInfo
        .carPhotoModels
        .first(where: { $0.viewType == .backRight })?
        .image?
        .jpegData(compressionQuality: .leastNonzeroMagnitude)?
        .base64EncodedString() ?? .empty,
      "comment": carCheckInfo.commentModel.text
    ]
  }
}

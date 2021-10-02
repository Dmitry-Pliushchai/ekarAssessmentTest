import Foundation
import CoreLocation

protocol CarPhotoCheckBusinessLogic {
  func fetchPhotoCheckInfo(request: CarPhotoCheck.FetchCarPhotoCheckInfo.Request)
  func validateCarPhotoCheckInfo(request: CarPhotoCheck.ValidateCarPhotoCheckInfo.Request)
}

protocol CarPhotoCheckDataStore {
  var coordinate: CLLocationCoordinate2D? { get set }
}

final class CarPhotoCheckInteractor: CarPhotoCheckDataStore {
  // MARK: - Dependencies
  private let presenter: CarPhotoCheckPresentationLogic
  private let worker: CarPhotoCheckWorker
  
  var coordinate: CLLocationCoordinate2D?
  
  // MARK: - Init
  init(presenter: CarPhotoCheckPresentationLogic, worker: CarPhotoCheckWorker) {
    self.presenter = presenter
    self.worker = worker
  }
}

// MARK: - CarPhotoCheckBusinessLogic
extension CarPhotoCheckInteractor: CarPhotoCheckBusinessLogic {
  func fetchPhotoCheckInfo(request: CarPhotoCheck.FetchCarPhotoCheckInfo.Request) {
    worker.fetchInfo { [weak self] result in
      switch result {
      case .success(let carPhotoCheckInfo):
        let response = CarPhotoCheck.FetchCarPhotoCheckInfo.Response(
          carPhotoCheckInfo: carPhotoCheckInfo
        )
        self?.presenter.presentPhotoCheckInfo(response: response)
      case .failure(let error):
        let response = CarPhotoCheck.ShowError.Response(error: error)
        self?.presenter.presentError(response: response)
      }
    }
  }
  
  func validateCarPhotoCheckInfo(request: CarPhotoCheck.ValidateCarPhotoCheckInfo.Request) {
    let model = request.carPhotoCheckInfo
    
    let imageValidationResult = model.carPhotoModels.reduce(true, { $0 && $1.image != nil })
    let commentValidationResult = !model.commentModel.text.isEmpty
    
    
    let validationResultBool = imageValidationResult && commentValidationResult
    
    let response = CarPhotoCheck.ValidateCarPhotoCheckInfo.Response(
      validationResult: validationResultBool ? .success : .failure,
      validationMessage: validationResultBool ? nil : "Please, fill all fields"
    )
    
    presenter.presentValidateCarPhotoCheckInfo(response: response)
    
    if validationResultBool {
      let request = CarPhotoCheck.SendData.Request(carPhotoCheckInfo: request.carPhotoCheckInfo)
      sendCarPhotoCheckInfo(request: request)
    }
  }
  
  func sendCarPhotoCheckInfo(request: CarPhotoCheck.SendData.Request) {
    guard let coordinate = coordinate else { return }
    let request = CarPhotoCheckRequest(coordinate: coordinate, carCheckInfo: request.carPhotoCheckInfo)
    
    worker.fetchInfo(request: request) { [weak self] result in
      switch result {
      case .success(let response):
        let response = CarPhotoCheck.SendData.Response(message: response.successMessage)
        self?.presenter.presentSendData(response: response)
      case .failure(let error):
        let response = CarPhotoCheck.ShowError.Response(error: error)
        self?.presenter.presentError(response: response)
      }
    }
  }
}

import Foundation

protocol CarPhotoCheckPresentationLogic {
  func presentPhotoCheckInfo(response: CarPhotoCheck.FetchCarPhotoCheckInfo.Response)
  func presentValidateCarPhotoCheckInfo(response: CarPhotoCheck.ValidateCarPhotoCheckInfo.Response)
  func presentSendData(response: CarPhotoCheck.SendData.Response)
  func presentError(response: CarPhotoCheck.ShowError.Response)
}

final class CarPhotoCheckPresenter {
  // MARK: - Dependencies
  private weak var viewController: CarPhotoCheckDisplayLogic?
  
  // MARK: - Init
  init(viewController: CarPhotoCheckDisplayLogic) {
    self.viewController = viewController
  }
}

// MARK: - CarPhotoCheckPresentationLogic
extension CarPhotoCheckPresenter: CarPhotoCheckPresentationLogic {
  func presentPhotoCheckInfo(response: CarPhotoCheck.FetchCarPhotoCheckInfo.Response) {
    let viewModel = CarPhotoCheck.FetchCarPhotoCheckInfo.ViewModel(
      carPhotoCheckInfo: response.carPhotoCheckInfo
    )
    
    viewController?.displayPhotoCheckInfo(viewModel: viewModel)
  }
  
  func presentValidateCarPhotoCheckInfo(response: CarPhotoCheck.ValidateCarPhotoCheckInfo.Response) {
    let viewModel = CarPhotoCheck.ValidateCarPhotoCheckInfo.ViewModel(
      validationResult: response.validationResult,
      validationMessage: response.validationMessage
    )
    
    viewController?.displayValidateCarPhotoCheckInfo(viewModel: viewModel)
  }
  
  func presentSendData(response: CarPhotoCheck.SendData.Response) {
    let viewModel = CarPhotoCheck.SendData.ViewModel(message: response.message)
    viewController?.displaySendData(viewModel: viewModel)
  }
  
  func presentError(response: CarPhotoCheck.ShowError.Response) {
    let viewModel = CarPhotoCheck.ShowError.ViewModel(error: response.error)
    viewController?.displayError(viewModel: viewModel)
  }
}


import Foundation

enum CarPhotoCheck {
  enum FetchCarPhotoCheckInfo {
    struct Request {}

    struct Response {
      let carPhotoCheckInfo: CarPhotoCheckInfo
    }
    struct ViewModel {
      let carPhotoCheckInfo: CarPhotoCheckInfo
    }
  }
  
  enum ValidateCarPhotoCheckInfo {
    enum ValidationResult {
      case success, failure
    }
    
    struct Request {
      let carPhotoCheckInfo: CarPhotoCheckInfo
    }
    
    struct Response {
      let validationResult: ValidationResult
      let validationMessage: String?
    }
    
    struct ViewModel {
      let validationResult: ValidationResult
      let validationMessage: String?
    }
  }
  
  enum ShowError {
    struct Response {
      let error: Error
    }
    
    struct ViewModel {
      let error: Error
    }
  }
  
  enum SendData {
    struct Request {
      let carPhotoCheckInfo: CarPhotoCheckInfo
    }
    
    struct Response {
      let message: String
    }
    
    struct ViewModel {
      let message: String
    }
  }
}

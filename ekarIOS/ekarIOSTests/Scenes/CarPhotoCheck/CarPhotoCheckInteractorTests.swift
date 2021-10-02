@testable import ekarIOS
import XCTest

class CarPhotoCheckInteractorTests: XCTestCase {
  // MARK: - Subject under test
  var sut: CarPhotoCheckInteractor!
  private var presenterMock: CarPhotoCheckPresentationLogicMock!
  
  // MARK: - Test lifecycle
  override func setUp() {
    super.setUp()
    setupCarPhotoCheckInteractor()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  func setupCarPhotoCheckInteractor() {
    
    presenterMock = CarPhotoCheckPresentationLogicMock()
    sut = CarPhotoCheckInteractor(
      presenter: presenterMock,
      worker: CarPhotoCheckWorker(
        carPhotoCheckStore: CarPhotoCheckLocalStore(),
        carPhotoCheckApiStore: CarPhotoCheckApiStoreMock())
    )
  }
  
  // MARK: - Mocks
  final private class CarPhotoCheckPresentationLogicMock: CarPhotoCheckPresentationLogic {
    var presentPhotoCheckInfoCalled = false
    var presentValidateCarPhotoCheckInfoCalled = false
    var presentSendDataCalled = false
    var presentErrorCalled = false
    
    func presentPhotoCheckInfo(response: CarPhotoCheck.FetchCarPhotoCheckInfo.Response) {
      presentPhotoCheckInfoCalled = true
    }
    
    func presentValidateCarPhotoCheckInfo(response: CarPhotoCheck.ValidateCarPhotoCheckInfo.Response) {
      presentValidateCarPhotoCheckInfoCalled = true
    }
    
    func presentSendData(response: CarPhotoCheck.SendData.Response) {
      presentSendDataCalled = true
    }
    
    func presentError(response: CarPhotoCheck.ShowError.Response) {
      presentErrorCalled = true
    }
  }
  
  final private class CarPhotoCheckApiStoreMock: CarPhotoCheckApiStore {
    func fetchInfo(request: URLRequestConvertible, completion: @escaping (Result<CommonResponse, Error>) -> Void) {
      completion(.success(.init(successMessage: "ok")))
    }
  }
  
  // MARK: - Tests
  func testValidateCarCheckInfo() {
    // Given
    let request = CarPhotoCheck.ValidateCarPhotoCheckInfo.Request(
      carPhotoCheckInfo: .init(
        titleModel: .init(title: .empty),
        carPhotoModels: [],
        commentModel: .init(headerText: .empty, text: "123", placeholder: .empty)
      )
    )
    
    // When
    sut.validateCarPhotoCheckInfo(request: request)
    
    // Then
    XCTAssertTrue(presenterMock.presentValidateCarPhotoCheckInfoCalled, "validateCarPhotoCheckInfo (request:) should ask the presenter to format the result")
  }
}

@testable import ekarIOS
import XCTest

class CarPhotoCheckPresenterTests: XCTestCase {
  // MARK: - Subject under test
  var sut: CarPhotoCheckPresenter!
  private var viewMock: CarPhotoCheckDisplayLogicMock!
  
  // MARK: - Test lifecycle
  override func setUp() {
    super.setUp()
    setupCarPhotoCheckPresenter()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  func setupCarPhotoCheckPresenter() {
    viewMock = CarPhotoCheckDisplayLogicMock()
    sut = CarPhotoCheckPresenter(
      viewController: viewMock
    )
  }
  
  // MARK: - Mocks
  final private class CarPhotoCheckDisplayLogicMock: CarPhotoCheckDisplayLogic {
    var displayPhotoCheckInfoCalled = false
    var displayValidateCarPhotoCheckInfoCalled = false
    var displaySendDataCalled = false
    var displayErrorCalled = false
    
    func displayPhotoCheckInfo(viewModel: CarPhotoCheck.FetchCarPhotoCheckInfo.ViewModel) {
      displayPhotoCheckInfoCalled = true
    }
    
    func displayValidateCarPhotoCheckInfo(viewModel: CarPhotoCheck.ValidateCarPhotoCheckInfo.ViewModel) {
      displayValidateCarPhotoCheckInfoCalled = true
    }
    
    func displaySendData(viewModel: CarPhotoCheck.SendData.ViewModel) {
      displaySendDataCalled = true
    }
    
    func displayError(viewModel: CarPhotoCheck.ShowError.ViewModel) {
      displayErrorCalled = true
    }
  }
  
  // MARK: - Tests
  func testShowError() {
    // Given
    let response = CarPhotoCheck.ShowError.Response(error: NetworkError.invalidURLRequest)
    
    // When
    sut.presentError(response: response)
    
    // Then
    XCTAssertTrue(viewMock.displayErrorCalled, "presentError(response:) should ask the view controller to display the result")
  }
}

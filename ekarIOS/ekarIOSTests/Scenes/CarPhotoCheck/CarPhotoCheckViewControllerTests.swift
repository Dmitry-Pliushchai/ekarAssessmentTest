@testable import ekarIOS
import XCTest

class CarPhotoCheckViewControllerTests: XCTestCase {
  // MARK: - Subject under test
  var sut: CarPhotoCheckViewController!
  var window: UIWindow!
  
  // MARK: - Test lifecycle
  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupCarPhotoCheckViewController()
  }
  
  override func tearDown() {
    window = nil
    super.tearDown()
  }
  
  // MARK: - Test setup
  func setupCarPhotoCheckViewController() {
    let storyboard = UIStoryboard(name: "CarPhotoCheck", bundle: nil)
    
    sut = (storyboard.instantiateViewController(
      withIdentifier: CarPhotoCheckViewController.className
    ) as! CarPhotoCheckViewController)
  }
  
  func loadView() {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: - Test doubles
  class CarPhotoCheckBusinessLogicSpy: CarPhotoCheckBusinessLogic {
    var fetchPhotoCheckInfoCalled = false
    var validateCarPhotoCheckInfoCalled = false
    
    func fetchPhotoCheckInfo(request: CarPhotoCheck.FetchCarPhotoCheckInfo.Request) {
      fetchPhotoCheckInfoCalled = true
    }
    func validateCarPhotoCheckInfo(request: CarPhotoCheck.ValidateCarPhotoCheckInfo.Request) {
      validateCarPhotoCheckInfoCalled = true
    }
  }
  
  // MARK: - Tests
  func testValidateCarCheckInfo() {
    // Given
    let spy = CarPhotoCheckBusinessLogicSpy()
    sut.interactor = spy
    
    // When
    loadView()
    
    sut.displayPhotoCheckInfo(
      viewModel: .init(
        carPhotoCheckInfo: .init(
          titleModel: .init(title: .empty),
          carPhotoModels: [],
          commentModel: .init(headerText: .empty, text: "123", placeholder: .empty)
        )))
    
    let button = sut.view.subviews.first(where: { $0 is UIButton }) as! UIButton
    button.sendActions(for: .touchUpInside)
    
    // Then
    XCTAssertTrue(spy.validateCarPhotoCheckInfoCalled, "Tap on button should ask the interactor to do validate info")
  }
}

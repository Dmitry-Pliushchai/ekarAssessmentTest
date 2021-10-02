import UIKit

protocol CarPhotoCheckDisplayLogic: AnyObject {
  func displayPhotoCheckInfo(viewModel: CarPhotoCheck.FetchCarPhotoCheckInfo.ViewModel)
  func displayValidateCarPhotoCheckInfo(viewModel: CarPhotoCheck.ValidateCarPhotoCheckInfo.ViewModel)
  func displaySendData(viewModel: CarPhotoCheck.SendData.ViewModel)
  func displayError(viewModel: CarPhotoCheck.ShowError.ViewModel)
}

private extension CarPhotoCheckViewController {
  enum Section: Int, CaseIterable {
    case title
    case carPhoto
    case comment
  }
}

final class CarPhotoCheckViewController: UIViewController, UINavigationControllerDelegate {
  @IBOutlet private var collectionView: UICollectionView!
  @IBOutlet private var closeButton: UIButton!
  @IBOutlet private var activityIndicator: UIActivityIndicatorView!
  
  var interactor: CarPhotoCheckBusinessLogic?
  var router: (CarPhotoCheckRoutingLogic & CarPhotoCheckDataPassing)?
  
  private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
  private var carPhotoCheckInfo: CarPhotoCheckInfo?
  
  private var selectedCarPhotoType: CarPhotoViewType?
  private var selectedCarPhotoIndexPath: IndexPath?
  
  private var hasLoaded = false
  
  private lazy var picker: UIImagePickerController = {
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.allowsEditing = false
    picker.delegate = self
    
    return picker
  }()
}

// MARK: - Life Cycle
extension CarPhotoCheckViewController {
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    guard !hasLoaded else { return }
    hasLoaded = true
    
    closeButton.setTitle("", for: .normal)
    
    registerCells()
    
    collectionView.contentInset.bottom = 120
    collectionView.collectionViewLayout = createLayout()
    configureDataSource()
    
    interactor?.fetchPhotoCheckInfo(request: CarPhotoCheck.FetchCarPhotoCheckInfo.Request())
  }
}

// MARK: - Actions
extension CarPhotoCheckViewController {
  @IBAction func closeButtonTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func submitButtonTapped(_ sender: Any) {
    guard let carPhotoCheckInfo = carPhotoCheckInfo else { return }
    
    interactor?.validateCarPhotoCheckInfo(
      request: CarPhotoCheck.ValidateCarPhotoCheckInfo.Request(
        carPhotoCheckInfo: carPhotoCheckInfo
      )
    )
  }
}

// MARK: - CarPhotoCheckDisplayLogic
extension CarPhotoCheckViewController: CarPhotoCheckDisplayLogic {
  func displayPhotoCheckInfo(viewModel: CarPhotoCheck.FetchCarPhotoCheckInfo.ViewModel) {
    carPhotoCheckInfo = viewModel.carPhotoCheckInfo
    updateDataSource()
  }
  
  func displayValidateCarPhotoCheckInfo(viewModel: CarPhotoCheck.ValidateCarPhotoCheckInfo.ViewModel) {
    switch viewModel.validationResult {
    case .success:
      activityIndicator.startAnimating()
    case .failure:
      let alert = UIAlertController(title: viewModel.validationMessage, message: nil, preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .default, handler: nil)
      
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
    }
  }
  
  func displaySendData(viewModel: CarPhotoCheck.SendData.ViewModel) {
    activityIndicator.stopAnimating()
    
    let alert = UIAlertController(title: viewModel.message, message: nil, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  func displayError(viewModel: CarPhotoCheck.ShowError.ViewModel) {
    activityIndicator.stopAnimating()
    
    let alert = UIAlertController(title: viewModel.error.localizedDescription, message: nil, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
}

// MARK: - Private
extension CarPhotoCheckViewController {
  func updateDataSource() {
    guard let carPhotoCheckInfo = carPhotoCheckInfo else { return }
    var titleSnapshot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
    titleSnapshot.append([carPhotoCheckInfo.titleModel])
    dataSource?.apply(titleSnapshot, to: .title)

    var carPhotoSnapshot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
    carPhotoSnapshot.append(carPhotoCheckInfo.carPhotoModels)
    dataSource?.apply(carPhotoSnapshot, to: .carPhoto)
    
    var commentSnapshot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
    commentSnapshot.append([carPhotoCheckInfo.commentModel])
    dataSource?.apply(commentSnapshot, to: .comment)
  }
}

// MARK: - UIImagePickerControllerDelegate
extension CarPhotoCheckViewController: UIImagePickerControllerDelegate {
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
  ) {
    picker.dismiss(animated: true)
    
    guard let image = info[.originalImage] as? UIImage else {
      return
    }
    
    guard
      let indexPath = selectedCarPhotoIndexPath,
      let id = dataSource?.itemIdentifier(for: indexPath),
      var currentSnapshot = dataSource?.snapshot()
    else { return }
    
    carPhotoCheckInfo?.carPhotoModels.first(where: { $0.viewType == selectedCarPhotoType })?.image = image
    
    currentSnapshot.reloadItems([id])
    dataSource?.apply(currentSnapshot)
  }
}

// MARK: - UICollectionView
extension CarPhotoCheckViewController {
  private func createLayout() -> UICollectionViewLayout {
    let sectionProvider = { (sectionIndex: Int, layout: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
      
      let section: NSCollectionLayoutSection
      
      switch sectionKind {
      case .title:
        let configution = UICollectionLayoutListConfiguration(appearance: .plain)
        section = NSCollectionLayoutSection.list(using: configution, layoutEnvironment: layout)
      case .carPhoto:
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let layout = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(150)
          ),
          subitem: item,
          count: 2
        )
        
        section = NSCollectionLayoutSection(group: layout)
      case .comment:
        let configution = UICollectionLayoutListConfiguration(appearance: .plain)
        section = NSCollectionLayoutSection.list(using: configution, layoutEnvironment: layout)
      }
      
      return section
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(
      collectionView: collectionView,
      cellProvider: { collectionView, indexPath, item -> UICollectionViewCell? in
        guard
          let section = Section(rawValue: indexPath.section)
        else { return UICollectionViewCell() }
        
        switch section {
        case .title:
          guard let item = item as? TitleModel else { return UICollectionViewCell() }

          let cell = collectionView.dequeueReusableCell(TitleCell.self, for: indexPath)
          cell.item = item

          return cell
        case .carPhoto:
          guard let item = item as? CarPhotoModel else { return UICollectionViewCell() }
          
          let cell = collectionView.dequeueReusableCell(CarPhotoCell.self, for: indexPath)
          
          cell.item = item
          cell.carPhotoSelected = { [weak self] type in
            guard let self = self else { return }
            self.selectedCarPhotoIndexPath = indexPath
            self.selectedCarPhotoType = type
            self.present(self.picker, animated: true, completion: nil)
          }
          
          return cell
        case .comment:
          guard let item = item as? CommentModel else { return UICollectionViewCell() }
          let cell = collectionView.dequeueReusableCell(CommentCell.self, for: indexPath)

          cell.item = item

          cell.textChangedHandler = { [weak self] value in
            self?.carPhotoCheckInfo?.commentModel.text = value
          }

          return cell
        }
      })
  }
  
  private func registerCells() {
    collectionView.registerNib(forType: TitleCell.self)
    collectionView.registerNib(forType: CarPhotoCell.self)
    collectionView.registerNib(forType: CommentCell.self)
  }
}

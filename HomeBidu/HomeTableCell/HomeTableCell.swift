import UIKit

class HomeTableCell: UITableViewCell {
  @IBOutlet weak var interactiveView: InteractiveView!
  @IBOutlet weak var infoView: InfoView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  static let identifier = Identifier.tableIdentifier
  private lazy var models = [UserModels]()
}

//MARK: - Life Cycle
extension HomeTableCell {
  override func awakeFromNib() {
    super.awakeFromNib()
    rigisterCollectionCell()
  }
}

//MARK: - Help HomeTableCell
extension HomeTableCell {
  public func configure(with models: [UserModels]){
    self.models = models
    collectionView.reloadData()
  }
  static func nib() -> UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  private func rigisterCollectionCell() {
    collectionView.register(HomeCollectionCell.nib(), forCellWithReuseIdentifier: HomeCollectionCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
}

//MARK: - TableViewDataSource
extension HomeTableCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier, for: indexPath) as! HomeCollectionCell
    cell.configure(with: models[indexPath.row])
    return cell
  }
}

//MARK: - TableViewDelegate
extension HomeTableCell: UICollectionViewDelegate {}

//MARK: - TableViewDelegateFlowLayout
extension HomeTableCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
}

import UIKit

class TableCell: UITableViewCell{
  static let identifier = Identifier.tableIdentifier
  static func nib() ->UINib {
    return UINib(nibName: Identifier.tableIdentifier, bundle: nil)
  }
  
  func configure(with models: [Model]){
    self.models = models
    collectionView.reloadData()
  }
  
  @IBOutlet weak var collectionView: UICollectionView!
  var models = [Model]()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    collectionView.register(HomeCell.nib(), forCellWithReuseIdentifier: HomeCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.layer.cornerRadius = 20
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

//MARK: - TableViewDataSource
extension TableCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
    cell.configure(with: models[indexPath.row])
    return cell
  }
  
}

//MARK: - TableViewDelegate
extension TableCell: UICollectionViewDelegate {
  func collection(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
}

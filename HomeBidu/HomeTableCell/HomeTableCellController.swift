import UIKit

class HomeTableCell: UITableViewCell {
  private var img: [File]?
  
  @IBOutlet weak var interactiveView: InteractiveView?
  @IBOutlet weak var infoView: InfoView?
  @IBOutlet weak var collectionView: UICollectionView?
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
  public func getTableCell(with feed: FeedData){
    img = feed.fileImage
    collectionView?.reloadData()
  }
}

//MARK: - TableViewDataSource
extension HomeTableCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if img?.count != 0 {
      return img!.count
    }
    return  0
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.getNibName(),
                                                  for: indexPath) as! HomeCollectionCell
    cell.getCollectionCell(with: (img?[indexPath.row])!)
    return cell
    
  }
}
//MARK: - TableViewDelegate
extension HomeTableCell: UICollectionViewDelegate {}
//MARK: - Protocol BaseCell
extension UICollectionView: BaseCellProtocol {}

//MARK: - Private
//MARK: - Rigister CollectionCell
extension HomeTableCell {
  private func rigisterCollectionCell() {
    collectionView?.register(HomeCollectionCell.getNib(),
                             forCellWithReuseIdentifier: HomeCollectionCell.getNibName())
    collectionView?.delegate = self
    collectionView?.dataSource = self
  }
}

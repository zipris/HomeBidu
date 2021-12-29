import UIKit

class TableCell: UITableViewCell{
  
  var countLike: Int = 30
  var countCmt: Int = 32
  var isLike: Bool = true
  var isCmt: Bool = true
  
  @IBOutlet weak var avatarImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var activeLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var hagtagLabel: UILabel!
  @IBOutlet weak var likeButton: UIButton!
  
  @IBOutlet weak var countLikeLabel: UILabel!
  @IBOutlet weak var countCmtLabel: UILabel!
  
  @IBAction func likeButton(_ sender: Any) {
    isLike = !isLike
    if isLike {
      likeButton.setImage(UIImage(named: Image.heart), for: .normal)
      countLike -= 1
    } else {
      likeButton.setImage(UIImage(named: Image.redHeart), for: .normal)
      countLike += 1
    }
    countLikeLabel.text = String(countLike)
  }
  
  @IBAction func cmtButton(_ sender: Any) {
    isCmt = !isCmt
    if isCmt {
      countCmt -= 1
    } else {
      countCmt += 1
    }
    countCmtLabel.text = String(countCmt)
  }
  
  @IBAction func shareButton(_ sender: Any) {
    print(Button.shared)
  }
  
  @IBAction func saveButton(_ sender: Any) {
    print(Button.save)
  }
  @IBAction func moreButton(_ sender: Any) {
    print(Button.more)
  }
  
  @IBOutlet weak var rightTab: UIView!
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
    designRightTab()
    designAvatar()
    
  }
  
  func designRightTab() {
    rightTab.layer.cornerRadius = rightTab.frame.size.width / 2
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func designAvatar() {
    avatarImage?.layer.cornerRadius = (avatarImage?.frame.size.height)! / 2
    avatarImage?.layer.masksToBounds = false
    avatarImage?.layer.borderWidth = 2
    avatarImage?.layer.borderColor = UIColor.red.cgColor
    avatarImage?.clipsToBounds = true
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

import UIKit

class HomeCollectionCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
}

//MARK: - Life Cycle
extension HomeCollectionCell {
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

//MARK: - Help HomeColletionCell
extension HomeCollectionCell {
  public func configure(with model: UserModels) {
    self.imageView.image = UIImage(named: model.imageName)
    self.imageView.contentMode = .scaleAspectFill
  }
}
//MARK: - Protocol BaseCell
extension HomeCollectionCell: BaseCellProtocol {}


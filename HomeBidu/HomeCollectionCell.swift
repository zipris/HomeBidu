import UIKit

class HomeCollectionCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  static let identifier = Identifier.homeIdentifier
}

//MARK: - Life Cycle
extension HomeCollectionCell {
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

//MARK: - Help HomeColletionCell
extension HomeCollectionCell {
  static func nib() -> UINib {
    return UINib(nibName: Identifier.homeIdentifier, bundle: nil)
  }
  public func configure(with model: UserModels) {
    self.imageView.image = UIImage(named: model.imageName)
    self.imageView.contentMode = .scaleAspectFill
  }
}

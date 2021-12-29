import UIKit

class HomeCell: UICollectionViewCell {

  static let identifier = Identifier.homeIdentifier

  @IBOutlet weak var imageView: UIImageView!

  static func nib() -> UINib {
    return UINib(nibName: Identifier.homeIdentifier, bundle: nil)
  }
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  public func configure(with model: Model) {
    self.imageView.image = UIImage(named: model.imageName)
    self.imageView.contentMode = .scaleAspectFill
  }
}

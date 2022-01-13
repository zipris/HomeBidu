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
  public func getCollectionCell(with file: File) {
    imageView.image = nil
    let url = URL(string: file.url!)
    imageView.loadImage(at: url!)
    imageView.contentMode = .scaleAspectFill
  }
}

//MARK: - Protocol BaseCell
extension HomeCollectionCell: BaseCellProtocol {}


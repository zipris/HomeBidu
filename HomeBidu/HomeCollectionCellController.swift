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
extension HomeCollectionCell: FetchableImage {
  public func getCollectionCell(with file: File) {
    imageView.image = UIImage(named: Image.Background)
    guard let url = file.url else {return}
    fetchImage(from: url, options: nil) { (avatarData) in
      if let data = avatarData {
        DispatchQueue.main.async {
          self.imageView.image = UIImage(data: data)
        }
      }
    }
    imageView.contentMode = .scaleAspectFill
  }
}

//MARK: - Protocol BaseCell
extension HomeCollectionCell: BaseCellProtocol {}

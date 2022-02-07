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

//MARK: - setupData
extension HomeCollectionCell: FetchableImage {
    func setupData(withFile file: FeedFileModel) {
        imageView.image = #imageLiteral(resourceName: "background")
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


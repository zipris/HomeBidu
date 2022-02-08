import UIKit

class HomeCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}

//MARK: - Life Cycle
extension HomeCollectionCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
    }
}

//MARK: - setupData
extension HomeCollectionCell: FetchableImage {
    func setupData(withFile file: FeedFileModel) {
        imageView.image = #imageLiteral(resourceName: "background")
        guard let url = file.url else {return}
        fetchImage(from: url, options: nil) {[weak self] avatarData in
            guard let self = self,
                  let data = avatarData else { return }
            self.imageView.image = UIImage(data: data)
            }
        }

    }



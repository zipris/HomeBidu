import UIKit

class HomeTableCell: UITableViewCell {
    private var files: [FeedFileModel] = []
    @IBOutlet weak var interactiveView: InteractiveView!
    @IBOutlet weak var informationView: InformationView!
    @IBOutlet weak var collectionView: UICollectionView!
}

//MARK: - Life Cycle
extension HomeTableCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionCell()
    }
}

//MARK: - Helper
extension HomeTableCell {
    private func registerCollectionCell() {
        collectionView.registerCell(Identifier.HomeIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupData(withFeed feed: FeedPostModel) {
        files = feed.fileImage ?? []
        informationView.getInformation(with: feed)
        interactiveView.getInteractive(with: feed)
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension HomeTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return files.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.cellIdentifier,
                                                      for: indexPath) as! HomeCollectionCell
        let file = files[indexPath.item]
        cell.setupData(withFile: file)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomeTableCell: UICollectionViewDelegate {}


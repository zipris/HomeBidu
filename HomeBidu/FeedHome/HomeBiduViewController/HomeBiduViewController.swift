import UIKit

class HomeBiduViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var feeds = [FeedPostModel]()
}

//MARK: - Life Cycle
extension HomeBiduViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
        getData()
    }
}

//MARK: - API
extension HomeBiduViewController {
    private func getData () {
        NetWorkService.shared.feedDataRequest() { [weak self] (results) in
            switch results {
            case .success(let listOf):
                self?.feeds = listOf.filter{$0.fileImage!.count > 0}
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK: - Helper
extension HomeBiduViewController {
    private func registerTableCell() {
        tableView.registerCell(HomeTableCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension HomeBiduViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.cellIdentifier,
                                                 for: indexPath) as! HomeTableCell
        let feed = feeds[indexPath.row]
        cell.setupData(withFeed: feed)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HomeBiduViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height * CGFloat(K.Constants.sizeIphone)
    }
}


import UIKit

class HomeBiduViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var feed = [FeedData]()
}
////MARK: - Life Cycle
extension HomeBiduViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    getData()
    rigisterTableCell()
  }
}

//MARK: - TableViewDataSource
extension HomeBiduViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if feed.count != 0 {
      return feed.count
    }
    return 0
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.getNibName(),
                                             for: indexPath) as! HomeTableCell
    let row = feed[indexPath.row]
    cell.getTableCell(with: row)
    cell.infoView?.getInfo(with: row)
    cell.interactiveView?.getInteractive(with: row)
    return cell
  }
}

//MARK: - TableViewDelegate
extension HomeBiduViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.frame.size.height * CGFloat(sizeIphone)
  }
}

//MARK: - Protocol BaseCell
extension UITableViewCell: BaseCellProtocol {}

//MARK: - Private
//MARK: - Help Methods
extension HomeBiduViewController {
  private func rigisterTableCell() {
    tableView.register(HomeTableCell.getNib(), forCellReuseIdentifier: HomeTableCell.getNibName())
    tableView.delegate = self
    tableView.dataSource = self
  }
}

//MARK: - Get Data Api
extension HomeBiduViewController {
  private func getData () {
    NetWorkService.shared.feedDataRequest() { [weak self] (results) in
      switch results {
      case .success(let listOf):
        self?.feed = listOf.filter{$0.fileImage!.count > 0}
      case .failure(let error):
        print(error.localizedDescription)
      }
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
  }
}

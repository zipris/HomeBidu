import UIKit

class HomeBiduViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  private lazy var models = [UserModels]()
  private let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(File.plist)
}

//MARK: - Life Cycle
extension HomeBiduViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    models.append(UserModels.init(name: "1", active: "2", status: "3", hagtag: "4", imageName: "image_1"))
    models.append(UserModels.init(name: "1", active: "2", status: "3", hagtag: "4", imageName: "image_2"))
    models.append(UserModels.init(name: "1", active: "2", status: "3", hagtag: "4", imageName: "image_3"))
    models.append(UserModels.init(name: "1", active: "2", status: "3", hagtag: "4", imageName: "image_4"))
    models.append(UserModels.init(name: "1", active: "2", status: "3", hagtag: "4", imageName: "image_5"))
    saveItems()
    rigisterTableCell()
  }
}

//MARK: - Help Methods
extension HomeBiduViewController {
  private func saveItems() {
    let encoder = PropertyListEncoder()
    do {
      let data = try encoder.encode(models)
      try data.write(to: self.dataFilePath!)
    } catch {
      print(Notification.errorData)
    }
    self.tableView.reloadData()
  }
  private func loadItems() {
    if let data = try? Data(contentsOf: dataFilePath!) {
      let decoder = PropertyListDecoder()
      do {
        models = try decoder.decode([UserModels].self, from: data)
      } catch {
        print(Notification.errorData + "\(error)")
      }
    }
  }
  private func rigisterTableCell() {
    loadItems()
    tableView.register(HomeTableCell.nib(), forCellReuseIdentifier: HomeTableCell.identifier)
    tableView.delegate = self
    tableView.dataSource = self
  }
}

//MARK: - TableViewDataSource
extension HomeBiduViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 10
  }
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    headerView.backgroundColor = .clear
    return headerView
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.identifier, for: indexPath) as! HomeTableCell
    cell.configure(with: models)
    return cell
  }
}

//MARK: - TableViewDelegate
extension HomeBiduViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.frame.size.height * 0.8
  }
}

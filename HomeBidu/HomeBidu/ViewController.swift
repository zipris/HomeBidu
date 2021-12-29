import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  var models = [Model]()
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(File.plist)

  override func viewDidLoad() {
    super.viewDidLoad()
    loadItems()
    tableView.register(TableCell.nib(), forCellReuseIdentifier: TableCell.identifier)
    tableView.delegate = self
    tableView.dataSource = self
    print(dataFilePath ?? Notification.find)

  }
  //MARK: - Model Manupulation Methods
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
        models = try decoder.decode([Model].self, from: data)
      } catch {
        print(Notification.errorData + "\(error)")
      }
    }
  }
}

//MARK: - TableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as! TableCell
    cell.configure(with: models)
    let infoView = InfoView(frame: CGRect(x: 10, y: 530, width: tableView.frame.size.width, height: tableView.frame.size.height))
    cell.addSubview(infoView)
    let tab = InteractiveView(frame: CGRect(x: tableView.frame.size.width - 50, y: 175, width: 50, height: 375))
    tab.layer.cornerRadius = tab.frame.size.width / 2
    tab.layer.masksToBounds = false
    cell.addSubview(tab)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.bounds.size.height
  }

}

//MARK: - TableViewDelegate
extension ViewController: UITableViewDelegate{}

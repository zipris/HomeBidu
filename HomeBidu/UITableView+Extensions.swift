import UIKit

extension UITableView {
    func registerCell(_ celldentifier: String) {
        register(UINib(nibName: celldentifier, bundle: nil),
                 forCellReuseIdentifier: celldentifier)
    }
}

extension UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self.self)
    }
}


import UIKit

extension UICollectionView {
    func registerCell(_ celldentifier: String) {
        register(UINib(nibName: celldentifier, bundle: nil),
                 forCellWithReuseIdentifier: celldentifier)
    }
}

extension UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self.self)
    }
}

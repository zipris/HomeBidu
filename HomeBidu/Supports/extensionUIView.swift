import UIKit

public extension UIView {
  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
}
protocol BaseCellProtocol {
    static func getNibName() -> String
    static func getNib() -> UINib
}

extension BaseCellProtocol where Self : UIView {
    static func getNibName() -> String {
        return String(describing: self)
    }

    static func getNib() -> UINib {
        return UINib.init(nibName: self.getNibName(), bundle: nil)
    }
}

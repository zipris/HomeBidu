import UIKit

//MARK: - Insert View
public extension UIView {
  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
}

//MARK: - Protocol And Extension Basic Cell
public protocol BaseCellProtocol {
  static func getNibName() -> String
  static func getNib() -> UINib
}

public extension BaseCellProtocol where Self : UIView {
  static func getNibName() -> String {
    return String(describing: self)
  }
  
  static func getNib() -> UINib {
    return UINib.init(nibName: getNibName(), bundle: nil)
  }
}


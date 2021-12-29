import Foundation
import UIKit

class InteractiveView: UIView {

  var likeButton: UIButton?
  var countLikeLabel: UILabel?
  var countLike: Int = 30
  var isLike: Bool = true

  var cmtButton: UIButton?
  var countCmtLabel: UILabel?
  var countCmt: Int = 32
  var isCmt: Bool = true

  var shareButton: UIButton?
  var saveButton: UIButton?
  var moreButon: UIButton?

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(white: 1, alpha: 0.3)
    setupTab()
  }

  required init?(coder: NSCoder) {
    fatalError(Notification.fatalError)
  }
}
//MARK: - Setup Tab
extension InteractiveView {
  func setupTab(){

    //add like button
    likeButton = UIButton(frame: CGRect(x: 5, y: 10, width: 40, height: 40))
    likeButton!.setImage(UIImage(named: Image.heart), for: .normal)
    likeButton!.addTarget(self, action: #selector(selectedLike), for: .touchUpInside)
    self.addSubview(likeButton!)

    //add like button label
    countLikeLabel = UILabel(frame: CGRect(x: 5, y: 50, width: 40, height: 35))
    countLikeLabel!.text = String(countLike)
    countLikeLabel!.textAlignment = .center
    countLikeLabel!.textColor = .white
    self.addSubview(countLikeLabel!)

    //add cmt button
    cmtButton = UIButton(frame: CGRect(x: 5, y: 90, width: 40, height: 40))
    cmtButton!.setImage(UIImage(named: Image.chat), for: .normal)
    cmtButton!.addTarget(self, action: #selector(selectedCmt), for: .touchUpInside)
    self.addSubview(cmtButton!)
    //add cmt button label
    countCmtLabel = UILabel(frame: CGRect(x: 5, y: 130, width: 40, height: 35))
    countCmtLabel!.text = String(countCmt)
    countCmtLabel!.textAlignment = .center
    countCmtLabel!.textColor = .white
    self.addSubview(countCmtLabel!)

    //add share button
    shareButton = UIButton(frame: CGRect(x: 5, y: 170, width: 40, height: 75))
    shareButton!.setImage(UIImage(named: Image.share), for: .normal)
    shareButton!.addTarget(self, action: #selector(selectedShared), for: .touchUpInside)
    self.addSubview(shareButton!)
    //add share button
    saveButton = UIButton(frame: CGRect(x: 5, y: 245, width: 40, height: 75))
    saveButton!.setImage(UIImage(named: Image.save), for: .normal)
    saveButton!.addTarget(self, action: #selector(selectedSave), for: .touchUpInside)
    self.addSubview(saveButton!)

    moreButon = UIButton(frame: CGRect(x: 5, y: 300, width: 40, height: 75))
    moreButon!.setImage(UIImage(named: Image.more), for: .normal)
    moreButon!.addTarget(self, action: #selector(selectedMore), for: .touchUpInside)
    self.addSubview(moreButon!)
  }
}

//MARK: - Action
extension InteractiveView {
  @objc func selectedLike() {
    isLike = !isLike
    if isLike {
      likeButton!.setImage(UIImage(named: Image.heart), for: .normal)
      countLike -= 1
    } else {
      likeButton!.setImage(UIImage(named: Image.redHeart), for: .normal)
      countLike += 1
    }
    countLikeLabel!.text = String(countLike)
  }

  @objc func selectedCmt() {
    isCmt = !isCmt
    if isCmt {
      countCmt -= 1
    } else {
      countCmt += 1
    }
    countCmtLabel!.text = String(countCmt)
  }
  @objc func selectedShared(){
    print(Button.shared)
  }
  @objc func selectedSave(){
    print(Button.save)
  }
  @objc func selectedMore(){
    print(Button.more)
  }
}

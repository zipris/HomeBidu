import Foundation
import UIKit

class InfoView: UIView {

  var avatarImageView: UIImageView?
  var followButton: UIButton?
  var nameLabel: UILabel?
  var activeLabel: UILabel?
  var statusLabel: UILabel?
  var hagtagLabel: UILabel?

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError(Notification.fatalError)
  }
}

//MARK: - Setup View
extension InfoView {
  func setupView() {

    //add user avatar
    avatarImageView = UIImageView(image: UIImage(named: Image.avatar))
    avatarImageView!.frame = CGRect(x: 0, y: 0, width: 60 , height: 60)
    avatarImageView!.layer.cornerRadius = avatarImageView!.frame.size.width / 2
    avatarImageView!.layer.masksToBounds = false
    avatarImageView!.layer.borderWidth = 2
    avatarImageView!.layer.borderColor = UIColor.red.cgColor
    avatarImageView!.clipsToBounds = true
    avatarImageView!.contentMode = .scaleAspectFill
    self.addSubview(avatarImageView!)

    //add name label
    nameLabel = UILabel(frame: CGRect(x: 62, y: 5, width: 200, height: 30))
    nameLabel!.text = Info.name
    nameLabel!.textAlignment = .left
    nameLabel!.textColor = .white
    nameLabel!.font = UIFont.boldSystemFont(ofSize: 20)
    self.addSubview(nameLabel!)

    //add active label
    activeLabel = UILabel(frame: CGRect(x: 62, y: 27, width: 200, height: 30))
    activeLabel!.text = Info.active
    activeLabel!.textAlignment = .left
    activeLabel!.textColor = .white
    activeLabel!.font = UIFont.systemFont(ofSize: 15)
    self.addSubview(activeLabel!)

    //add status label
    statusLabel = UILabel(frame: CGRect(x: 5, y: 50, width: 400, height: 100))
    statusLabel!.text = Info.status
    statusLabel!.numberOfLines = 5
    statusLabel!.textAlignment = .left
    statusLabel!.textColor = .white
    statusLabel!.font = UIFont.systemFont(ofSize: 20)
    self.addSubview(statusLabel!)

    //add hagtag label
    hagtagLabel = UILabel(frame: CGRect(x: 5, y: 160, width: 400, height: 20))
    hagtagLabel!.text = Info.hagtag
    hagtagLabel!.textAlignment = .left
    hagtagLabel!.textColor = .white
    hagtagLabel!.font = UIFont.systemFont(ofSize: 15)
    self.addSubview(hagtagLabel!)

    //add follow button
    followButton = UIButton(frame: CGRect(x: 40, y: 40, width: 20, height: 20))
    followButton!.layer.cornerRadius = followButton!.frame.size.width / 2
    followButton!.layer.masksToBounds = false
    avatarImageView!.layer.borderWidth = 2
    avatarImageView!.layer.borderColor = UIColor.red.cgColor
    avatarImageView!.clipsToBounds = true
    followButton!.backgroundColor = .white
    followButton!.setTitle(Info.plus, for: .normal)
    followButton?.setTitleColor(.black, for: .normal)
    followButton!.addTarget(self, action: #selector(buttonFollow), for: .touchUpInside)
    self.addSubview(followButton!)

  }
}

//MARK: - Action
extension InfoView {
  @objc func buttonFollow(sender: UIButton!) {
    followButton?.isHidden = true
    print(Button.follow)
  }
}

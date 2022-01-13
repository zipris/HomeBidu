import UIKit
class InfoView: UIView {
  var feed: FeedData?
  private lazy var avatarImageView: UIImageView = {
    let image = UIImageView()
    image.image = nil
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 22
    image.layer.masksToBounds = false
    image.layer.borderWidth = 2.0
    image.layer.borderColor = UIColor.red.cgColor
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  private lazy var nameLabel: UILabel = {
    let name = UILabel()
    name.textAlignment = .left
    name.textColor = .white
    name.font = UIFont(name: Font.lexendSemiBoldFont, size: 16.0)
    name.translatesAutoresizingMaskIntoConstraints = false
    return name
  }()
  private lazy var famousImageView: UIImageView = {
    let famous = UIImageView()
    famous.image = UIImage(named: Image.famous)
    famous.contentMode = .scaleAspectFill
    famous.translatesAutoresizingMaskIntoConstraints = false
    return famous
  }()
  private lazy var followButton: UIButton = {
    let follow = UIButton()
    follow.setImage(UIImage(named: Image.follow), for: .normal)
    follow.addTarget(self,
                     action: #selector(buttonFollow),
                     for: .touchUpInside)
    follow.translatesAutoresizingMaskIntoConstraints = false
    return follow
  }()
  private lazy var activeLabel: UILabel = {
    let active = UILabel()
    active.text = Info.active
    active.textAlignment = .left
    active.textColor = .white
    active.font = UIFont(name: Font.JosefinSansRegularFont, size: 13.0)
    active.translatesAutoresizingMaskIntoConstraints = false
    return active
  }()
  private lazy var statusLabel: UILabel = {
    let status = UILabel()
    status.text = Info.status
    status.textAlignment = .left
    status.textColor = .white
    status.numberOfLines = 3
    status.font = UIFont(name: Font.lexendRegularFont, size: 14.0)
    status.translatesAutoresizingMaskIntoConstraints = false
    return status
  }()
  private lazy var hagtagLabel: UILabel = {
    let hagtag = UILabel()
    hagtag.text = feed?.content
    hagtag.textAlignment = .left
    hagtag.textColor = .white
    hagtag.font = UIFont(name: Font.lexendRegularFont, size: 10.0)
    hagtag.translatesAutoresizingMaskIntoConstraints = false
    return hagtag
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupInfo()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupInfo()
  }
}

//MARK: - Setup View
extension InfoView {
  private func setupInfo() {
    backgroundColor = .clear
    setupView()
    setupConstaints()
  }
  private func setupView(){
    addSubviews(avatarImageView,
                nameLabel,
                famousImageView,
                activeLabel,
                followButton,
                statusLabel,
                hagtagLabel)
  }
  private func setupConstaints(){
    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      avatarImageView.widthAnchor.constraint(equalToConstant: 44),
      avatarImageView.heightAnchor.constraint(equalToConstant: 44)
    ])

    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
      nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10)
    ])

    NSLayoutConstraint.activate([
      famousImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      famousImageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
    ])

    NSLayoutConstraint.activate([
      activeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
      activeLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
      activeLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])

    NSLayoutConstraint.activate([
      followButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -20),
      followButton.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: -20),
      followButton.trailingAnchor.constraint(equalTo: activeLabel.leadingAnchor)
    ])

    NSLayoutConstraint.activate([
      statusLabel.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: 5),
      statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    
    NSLayoutConstraint.activate([
      hagtagLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor),
      hagtagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      hagtagLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      hagtagLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5)
    ])
  }
}

//MARK: - Action
extension InfoView {
  @objc private func buttonFollow(_ sender: UIButton) {
    followButton.isHidden = true
    print(Button.follow)
  }
}
extension InfoView {
  public func getInfo(with model: FeedData){
    nameLabel.text = model.author.userName
    let avatar = URL(string: model.author.avatar)!
    avatarImageView.loadImage(at: avatar)
    famousImageView.isHidden = model.author.isVerified
    followButton.isHidden = model.isFollow
    statusLabel.text = model.content
  }
}

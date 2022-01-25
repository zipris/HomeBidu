import UIKit

class InteractiveView: UIView {
  public var open: Bool?
  private var likeCount: Int?
  private lazy var likeButton: UIButton = {
    let likeButton = UIButton()
    likeButton.setImage(UIImage(named: Image.heart), for: .normal)
    likeButton.setImage(UIImage(named: Image.redHeart), for: .selected)
    likeButton.addTarget(self,
                         action: #selector(selectedLike),
                         for: .touchUpInside)
    likeButton.translatesAutoresizingMaskIntoConstraints = false
    return likeButton
  }()
  private lazy var cmtButton: UIButton = {
    let cmtButton = UIButton()
    cmtButton.setImage(UIImage(named: Image.chat), for: .normal)
    cmtButton.isSelected = false
    cmtButton.addTarget(self,
                        action: #selector(selectedCmt),
                        for: .touchUpInside)
    cmtButton.translatesAutoresizingMaskIntoConstraints = false
    return cmtButton
  }()
  private lazy var shareButton: UIButton = {
    let shareButton = UIButton()
    shareButton.setImage(UIImage(named: Image.share), for: .normal)
    shareButton.isSelected = false
    shareButton.addTarget(self,
                          action: #selector(selectedShared),
                          for: .touchUpInside)
    shareButton.translatesAutoresizingMaskIntoConstraints = false
    return shareButton
  }()
  private lazy var saveButton: UIButton = {
    let saveButton = UIButton()
    saveButton.setImage(UIImage(named: Image.save), for: .normal)
    saveButton.addTarget(self,
                         action: #selector(selectedSave),
                         for: .touchUpInside)
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    return saveButton
  }()
  private lazy var moreButon: UIButton = {
    let moreButton = UIButton()
    moreButton.setImage(UIImage(named: Image.more), for: .normal)
    moreButton.isSelected = false
    moreButton.addTarget(self,
                         action: #selector(selectedMore),
                         for: .touchUpInside)
    moreButton.translatesAutoresizingMaskIntoConstraints = false
    return moreButton
  }()
  private lazy var countLikeLabel: UILabel = {
    let countLikeLabel = UILabel()
    countLikeLabel.textAlignment = .center
    countLikeLabel.textColor = .white
    countLikeLabel.font = UIFont(name: Font.lexendRegularFont, size: 13.0)
    countLikeLabel.translatesAutoresizingMaskIntoConstraints = false
    return countLikeLabel
  }()
  private lazy var countCmtLabel: UILabel = {
    let countCmtLabel = UILabel()
    countCmtLabel.textAlignment = .center
    countCmtLabel.textColor = .white
    countCmtLabel.font = UIFont(name: Font.lexendRegularFont, size: 13.0)
    countCmtLabel.translatesAutoresizingMaskIntoConstraints = false
    return countCmtLabel
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupTab()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupTab()
  }
}

//MARK: - Setup View
extension InteractiveView {
  private func setupTab(){
    setupView()
    setupConstaints()
  }
  private func setupView() {
    layer.cornerRadius = frame.size.width / 2.5
    clipsToBounds = true
    layer.maskedCorners = [.layerMinXMaxYCorner,
                           .layerMinXMinYCorner]
    backgroundColor = UIColor(white: 1.0, alpha: 0.3)
    addSubviews(likeButton,
                countLikeLabel,
                cmtButton,
                countCmtLabel,
                shareButton,
                saveButton,
                moreButon)
  }
  private func setupConstaints() {
    NSLayoutConstraint.activate([
      likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      likeButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      likeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      likeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
      likeButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15)
    ])
    
    NSLayoutConstraint.activate([
      countLikeLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: -10),
      countLikeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      countLikeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      countLikeLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
      countLikeLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)
    ])
    
    NSLayoutConstraint.activate([
      cmtButton.topAnchor.constraint(equalTo: countLikeLabel.bottomAnchor),
      cmtButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      cmtButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      cmtButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
      cmtButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15)
    ])
    
    NSLayoutConstraint.activate([
      countCmtLabel.topAnchor.constraint(equalTo: cmtButton.bottomAnchor, constant: -10),
      countCmtLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      countCmtLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      countCmtLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
      countCmtLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
      
    ])
    
    NSLayoutConstraint.activate([
      shareButton.topAnchor.constraint(equalTo: countCmtLabel.bottomAnchor),
      shareButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      shareButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      shareButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
      shareButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
    ])
    
    NSLayoutConstraint.activate([
      saveButton.topAnchor.constraint(equalTo: shareButton.bottomAnchor),
      saveButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      saveButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      saveButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
      saveButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
    ])
    
    NSLayoutConstraint.activate([
      moreButon.topAnchor.constraint(equalTo: saveButton.bottomAnchor),
      moreButon.leadingAnchor.constraint(equalTo: leadingAnchor),
      moreButon.trailingAnchor.constraint(equalTo: trailingAnchor),
      moreButon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
      moreButon.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
      moreButon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])
  }
}

//MARK: - Action
extension InteractiveView {
  @objc private func selectedLike(_ sender: UIButton) {
    sender.isSelected.toggle()
    if sender.isSelected {
      countLikeLabel.text = String(likeCount! + 1)
    } else {
      countLikeLabel.text = String(likeCount!)
    }
  }
  @objc private func selectedCmt(_ sender: UIButton) {
  }
  @objc private func selectedShared(_ sender: UIButton) {
    print(Button.shared)
  }
  @objc private func selectedSave(_ sender: UIButton) {
    print(Button.save)
  }
  @objc private func selectedMore(_ sender: UIButton) {
    print(Button.more)
  }
}
extension InteractiveView {
  public func getInteractive(with interactive: FeedData) {
    countLikeLabel.text = String(interactive.likeCount)
    likeCount = interactive.likeCount
    likeButton.isSelected = interactive.isLike
    countCmtLabel.text = String(interactive.numberOfComments)
    saveButton.isSelected = interactive.isBookmark
  }
}


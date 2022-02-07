import UIKit

class InformationView: UIView {
    var feed: FeedPostModel?
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Image.Background)
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
        name.font = UIFont(name: Font.LexendSemiBoldFont, size: 16.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var famousImageView: UIImageView = {
        let famous = UIImageView()
        famous.image = UIImage(named: Image.Famous)
        famous.contentMode = .scaleAspectFill
        famous.translatesAutoresizingMaskIntoConstraints = false
        return famous
    }()
    
    private lazy var followButton: UIButton = {
        let follow = UIButton()
        follow.setImage(UIImage(named: Image.Follow), for: .normal)
        follow.addTarget(self,
                         action: #selector(buttonFollow),
                         for: .touchUpInside)
        follow.translatesAutoresizingMaskIntoConstraints = false
        return follow
    }()
    
    private lazy var activeLabel: UILabel = {
        let active = UILabel()
        active.text = Info.Active
        active.textAlignment = .left
        active.textColor = .white
        active.font = UIFont(name: Font.JosefinSansRegularFont, size: 13.0)
        active.translatesAutoresizingMaskIntoConstraints = false
        return active
    }()
    
    private lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.textAlignment = .left
        status.textColor = .white
        status.numberOfLines = 3
        status.font = UIFont(name: Font.LexendRegularFont, size: 14.0)
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    private lazy var hagtagLabel: UILabel = {
        let hagtag = UILabel()
        hagtag.text = feed?.content
        hagtag.textAlignment = .left
        hagtag.textColor = .white
        hagtag.font = UIFont(name: Font.LexendRegularFont, size: 10.0)
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
extension InformationView {
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
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
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
extension InformationView {
    @objc private func buttonFollow(_ sender: UIButton) {
        followButton.isHidden = true
        print(Button.Follow)
    }
}

//MARK: - getInformation
extension InformationView: FetchableImage {
    func getInformation(with feedInformation: FeedPostModel){
        nameLabel.text = feedInformation.author.userName
        famousImageView.isHidden = feedInformation.author.isVerified
        followButton.isHidden = feedInformation.isFollow
        statusLabel.text = feedInformation.content
        fetchImage(from: feedInformation.author.avatar, options: nil) { (avatarData) in
            if let data = avatarData {
                DispatchQueue.main.async {
                    self.avatarImageView.image = UIImage(data: data)
                }
            }
        }
    }
}

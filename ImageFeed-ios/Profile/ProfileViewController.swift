import UIKit
import Kingfisher

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfileViewPresenterProtocol? { get set }
    func updateProfileImage()
    func showLogoutAlert()
}

final class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    
    var presenter: ProfileViewPresenterProtocol?
    
    private var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = UIImage(named: "Avatar")
        return profileImage
    }()
    
    private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Екатерина Новикова"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        nameLabel.textColor = UIColor.ypWhite
        return nameLabel
    }()
    
    private var loginLabel: UILabel = {
        let loginLabel = UILabel()
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "@ekaterina_nov"
        loginLabel.font = UIFont.systemFont(ofSize: 13)
        loginLabel.textColor = UIColor.ypGray
        return loginLabel
    }()
    
    private var aboutLabel: UILabel = {
        let aboutLabel = UILabel()
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.text = "Hello, world!"
        aboutLabel.font = UIFont.systemFont(ofSize: 13)
        aboutLabel.textColor = UIColor.ypWhite
        return aboutLabel
    }()
    
    private let logoutButton: UIButton = {
        let logoutButton = UIButton()
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setImage(UIImage(named: "logout_button"), for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
        logoutButton.accessibilityIdentifier = "logoutButton"
        return logoutButton
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ypBlack
        addSubViews()
        applyConstraint()
        presenter?.observeProfileImage()
        presenter?.view = self
        updateProfileDetails()
        updateProfileImage()
        
    }
    
    private func addSubViews() {
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(loginLabel)
        view.addSubview(aboutLabel)
        view.addSubview(logoutButton)
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            profileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImage.heightAnchor.constraint(equalToConstant: 70),
            profileImage.widthAnchor.constraint(equalToConstant: 70),
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            loginLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            aboutLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8),
            aboutLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor)
        ])
    }
}

extension ProfileViewController {
    
    func configure(_ presenter: ProfileViewPresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    private func updateProfileDetails() {
        guard let profile = presenter?.getProfileDetails() else { return }
        nameLabel.text = profile.name
        loginLabel.text = profile.loginName
        aboutLabel.text = profile.bio
    }
    
    func updateProfileImage() {
        guard let url = presenter?.getProfileImageURL() else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 70, backgroundColor: .clear)
        profileImage.kf.indicatorType = .activity
        profileImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "person.crop.circle.fill.png"),
            options: [.processor(processor),
                      .cacheSerializer(FormatIndicatedCacheSerializer.png)]
        )
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
    }

    @objc private func logoutButtonAction() {
        showLogoutAlert()
    }
    
    func showLogoutAlert() {
        guard let alert = presenter?.showAlert() else { return }
        present(alert, animated: true, completion: nil)
    }

}

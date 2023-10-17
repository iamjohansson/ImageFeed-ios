import UIKit

protocol ProfileViewPresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func observeProfileImage()
    func showAlert() -> UIAlertController
    func getProfileImageURL() -> URL?
    func getProfileDetails() -> Profile?
}

final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    
    weak var view: ProfileViewControllerProtocol?
    private let token = OAuth2TokenStorage()
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let imageListService = ImageListService.shared
    private var profileImageObserver: NSObjectProtocol?
    
    func observeProfileImage() {
        profileImageObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.DidChangeNotification,
                object: nil,
                queue: .main) { [weak self] _ in
                    guard let self = self else { return }
                    view?.updateProfileImage()
                }
    }
    
    func getProfileImageURL() -> URL? {
        guard let profileImageURL = profileImageService.avatarURL,
              let url = URL(string: profileImageURL)
        else { return nil }
        return url
    }
    
    func getProfileDetails() -> Profile? {
        guard let profile = profileService.profile else { return nil }
        return profile
    }
    
    func showAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "Пока, пока!",
            message: "Уверены что хотите выйти?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Да", style: .default) { [weak self] alertAction in
            guard let self = self else { return }
            cleanAndSwitchToSplashView()
        })
        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: nil))
        alert.dismiss(animated: true)
        return alert
    }
    
    private func cleanAndSwitchToSplashView() {
        WebViewViewController.clean()
        profileImageService.clean()
        profileService.clean()
        imageListService.clean()
        token.clean()
        
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        window.rootViewController = SplashViewController()
    }
}

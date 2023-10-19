import Foundation

protocol ProfileViewPresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func observeProfileImage()
    func prepareAlert() -> (title: String, message: String, actionYes: String, actionNo: String)
    func getProfileImageURL() -> URL?
    func getProfileDetails() -> Profile?
    func cleanAndSwitchToSplashView()
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
    
    func prepareAlert() -> (title: String, message: String, actionYes: String, actionNo: String) {
        let title = "Пока, пока!"
        let message = "Уверены что хотите выйти?"
        let actionYes = "Да"
        let actionNo = "Нет"
        return (title, message, actionYes, actionNo)
    }
    
    func cleanAndSwitchToSplashView() {
        WebViewViewController.clean()
        profileImageService.clean()
        profileService.clean()
        imageListService.clean()
        token.clean()
        
        view?.switchToSplashScreen()
    }
}

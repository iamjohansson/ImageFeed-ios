import UIKit
@testable import ImageFeed_ios

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
    
    var view: ImageFeed_ios.ProfileViewControllerProtocol?
    private let profileService = ProfileService.shared
    var profileData = Profile(decoded: ProfileResult(username: "testNickname",
                                                     firstName: "test1stName",
                                                     lastName: "test2ndName",
                                                     bio: "aboutMe"))
    var viewDidLoadCalled = false
    var alertCheck = false
    var profileImageCheck = false
    var logoutCheck = false
    
    func observeProfileImage() {
        viewDidLoadCalled = true
    }
    
    func showAlert() -> UIAlertController {
        let alert = UIAlertController(title: "TestName", message: "Test?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        alert.dismiss(animated: true)
        alertCheck = true
        return alert
    }
    
    func getProfileImageURL() -> URL? {
        profileImageCheck = true
        return nil
    }
    
    func getProfileDetails() -> ImageFeed_ios.Profile? {
        let profile = profileData
        return profile
    }
    
    func cleanAndSwitchToSplashView() {
        logoutCheck = true
    }
    
}

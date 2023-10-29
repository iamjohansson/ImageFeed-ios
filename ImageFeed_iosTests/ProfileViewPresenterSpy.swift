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
    var profileImageCheck = false
    var logoutCheck = false
    
    func observeProfileImage() {
        viewDidLoadCalled = true
    }
    
    func prepareAlert() -> (title: String, message: String, actionYes: String, actionNo: String) {
        return ("AlertTitle", "AlertMessage", "Yes", "No")
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

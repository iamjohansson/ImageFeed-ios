import UIKit
@testable import ImageFeed_ios

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ImageFeed_ios.ProfileViewPresenterProtocol?
    var alertCheck = false
    
    func updateProfileImage() {

    }
    
    func showLogoutAlert() {
        alertCheck = true
    }
    
    
}

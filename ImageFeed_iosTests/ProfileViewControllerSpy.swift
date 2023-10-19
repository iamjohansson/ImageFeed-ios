import UIKit
@testable import ImageFeed_ios

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ImageFeed_ios.ProfileViewPresenterProtocol?
    var alertCheck = false
    var presenterSpy = ProfileViewPresenterSpy()

    func updateProfileImage() {

    }
    
    func showAlert() {
        let input = presenterSpy.prepareAlert()
        
        let alert = UIAlertController(title: input.title, message: input.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: input.actionYes, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: input.actionNo, style: .default, handler: nil))
        alertCheck = true
    }
    
    func switchToSplashScreen() {
        
    }
    
}

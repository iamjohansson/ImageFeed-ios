import UIKit

final class TabBarController: UITabBarController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let imageListViewController = storyboard.instantiateViewController(withIdentifier: "ImageListViewController")
        
        let profileViewController = ProfileViewController()
        profileViewController.configure(ProfileViewPresenter())
        profileViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Tab_profile_active"), selectedImage: nil)
        
        self.viewControllers = [imageListViewController, profileViewController]
    }
}

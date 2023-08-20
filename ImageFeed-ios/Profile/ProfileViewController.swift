import UIKit

final class ProfileViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = UIColor(named: "YP Black (iOS)")
    }
    
    
    func setup() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Avatar")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        
        label1.text = "Екатерина Новикова"
        label1.font = UIFont.boldSystemFont(ofSize: 23)
        label1.textColor = UIColor(named: "YP White (iOS)")
        
        label2.text = "@ekaterina_nov"
        label2.font = UIFont.systemFont(ofSize: 13)
        label2.textColor = UIColor(named: "YP Gray (iOS)")
        
        label3.text = "Hello, world!"
        label3.font = UIFont.systemFont(ofSize: 13)
        label3.textColor = UIColor(named: "YP White (iOS)")
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        label3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            label1.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 8),
            label2.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 8),
            label3.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
        
        let button = UIButton()
        button.setImage(UIImage(named: "Logout_button"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
    
}

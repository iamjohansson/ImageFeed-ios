import UIKit

final class ImageListCell: UITableViewCell {
    
    static let reuseIdentifier = "ImageListCell"
    private var gradientInit = false
    
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var gradient: UIView!
    
    func applyGradient() {
        if !gradientInit {
            let firstColor = UIColor(red: 26/255, green: 27/255, blue: 34/255, alpha: 0)
            let lastColor = UIColor(red: 26/255, green: 27/255, blue: 34/255, alpha: 0.2)
            
            let gradientLayer: CAGradientLayer = CAGradientLayer()
            gradientLayer.frame = self.gradient.bounds
            gradientLayer.colors = [firstColor.cgColor, lastColor.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            self.gradient.layer.insertSublayer(gradientLayer, at: 0)
            cellImage.addSubview(gradient)
            gradientInit.toggle()
        }
    }
}

import UIKit

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImageListCell)
}

final class ImageListCell: UITableViewCell {
    
    static let reuseIdentifier = "ImageListCell"
    private var gradientInit = false
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    weak var delegate: ImagesListCellDelegate?
    
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
    
    func setIsLike(entryValue: Bool) {
        let image = entryValue ? UIImage(named: "Like_button_active") : UIImage(named: "Like_button_inactive")
        likeButton.setImage(image, for: .normal)
    }
    
    @IBAction private func likeButtonClicked(_ sender: Any) {
        delegate?.imageListCellDidTapLike(self)
        feedbackGenerator.notificationOccurred(.success)
    }
}

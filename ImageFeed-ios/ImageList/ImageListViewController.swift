import UIKit
import Kingfisher

final class ImageListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private var photos: [Photo] = []
    private let showSingleImageSegueIdentifier = "ShowSingleImage"
    private var imageListServiceObserver: NSObjectProtocol?
    private let imageListService = ImageListService.shared
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        imageListServiceObserver = NotificationCenter.default.addObserver(
            forName: ImageListService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            self.updateTableViewAnimated()
        }
        imageListService.fetchPhotoNextPage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showSingleImageSegueIdentifier {
            guard let viewController = segue.destination as? SingleImageViewController,
                  let indexPath = sender as? IndexPath else { return }
            if let url = imageListService.photos[indexPath.row].largeImageURL,
               let imageURL = URL(string: url) {
                viewController.imageURL = imageURL
            }
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    private func updateTableViewAnimated() {
        let oldCount = photos.count
        let newCount = imageListService.photos.count
        photos = imageListService.photos
        if oldCount != newCount {
            tableView.performBatchUpdates {
                let indexPath = (oldCount..<newCount).map { IndexPath(row: $0, section: 0) }
                tableView.insertRows(at: indexPath, with: .fade)
            } completion: { _ in }
        }
    }
    
    private func configCell(for cell: ImageListCell, with indexPath: IndexPath) {
        if let url = imageListService.photos[indexPath.row].thumbImageURL,
           let imageURL = URL(string: url) {
            cell.applyGradient()
            cell.cellImage.kf.indicatorType = .activity
            cell.cellImage.kf.setImage(
                with: imageURL,
                placeholder: UIImage(named: "Stub")) { [weak self] _ in
                    guard let self = self else { return }
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            if let date = imageListService.photos[indexPath.row].createdAt {
                cell.dateLabel.text = dateFormatter.string(from: date as Date)
            } else {
                cell.dateLabel.text = "00-00"
            }
            let checkLike = indexPath.row % 2 == 0
            let setLike = checkLike ? UIImage(named: "Like_button_active") : UIImage(named: "Like_button_inactive")
            cell.likeButton.setImage(setLike, for: .normal)
        }
    }
}

extension ImageListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageListService.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImageListCell else {
            return UITableViewCell()
        }
        // delegate
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}

extension ImageListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = imageListService.photos[indexPath.row]
        
        let imageInsert = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsert.left - imageInsert.right
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let scale = imageViewWidth / imageWidth
        let cellHeight = imageHeight * scale + imageInsert.top + imageInsert.bottom
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == imageListService.photos.count {
            imageListService.fetchPhotoNextPage()
        }
    }
}

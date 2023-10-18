import UIKit

protocol ImageListViewPresenterProtocol: AnyObject {
    var view: ImageListViewControllerProtocol? { get set }
    var imageListService: ImageListService { get }
    var photos: [Photo] { get set }
    
    func viewDidLoad()
    func imageListCellDidTapLike(_ cell: ImageListCell, indexPath: IndexPath)
    func updateTableViewAnimation()
}

final class ImageListPresenter: ImageListViewPresenterProtocol {
    
    weak var view: ImageListViewControllerProtocol?
    let imageListService = ImageListService.shared
    var photos: [Photo] = []
    private var imageListServiceObserver: NSObjectProtocol?
    
    
    
    func viewDidLoad() {
        imageListServiceObserver = NotificationCenter.default.addObserver(
            forName: ImageListService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            updateTableViewAnimation()
        }
        imageListService.fetchPhotoNextPage()
    }
    
    func imageListCellDidTapLike(_ cell: ImageListCell, indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        UIBlockingProgressHUD.showNewHUD()
        imageListService.changeLike(photoId: photo.id, isLike: photo.isLiked) { result in
            switch result {
            case .success:
                self.photos = self.imageListService.photos
                cell.setIsLike(entryValue: self.photos[indexPath.row].isLiked)
                UIBlockingProgressHUD.dismiss()
            case .failure:
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    func updateTableViewAnimation() {
        let oldCount = photos.count
        let newCount = imageListService.photos.count
            photos = imageListService.photos
        if oldCount != newCount {
            view?.updateTableViewAnimated(oldCount: oldCount, newCount: newCount)
        }
    }
    
}

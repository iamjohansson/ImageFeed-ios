import UIKit
@testable import ImageFeed_ios

final class ImageListPresenterSpy: ImageListViewPresenterProtocol {
    
    var view: ImageFeed_ios.ImageListViewControllerProtocol?
    var imageListService: ImageFeed_ios.ImageListService
    var photos: [ImageFeed_ios.Photo] = []
    var viewDidLoadCalled = false
    var changeLikeCalled = false
    var tableViewUpdateCheck = false
    
    init(imageListService: ImageListService) {
        self.imageListService = imageListService
    }
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func imageListCellDidTapLike(_ cell: ImageFeed_ios.ImageListCell, indexPath: IndexPath) {
        changeLike(photoId: "123", isLike: false) { _ in }
    }
    
    func updateTableViewAnimation() {
        tableViewUpdateCheck = true
    }

    func changeLike(photoId: String, isLike: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        changeLikeCalled = true
    }
    
}

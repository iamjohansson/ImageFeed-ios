import XCTest
@testable import ImageFeed_ios

final class ImageListViewTests: XCTestCase {

    func testViewControllerCallsViewDidLoad() {
        //given
        let vc = ImageListViewController()
        let presenter = ImageListPresenterSpy(imageListService: ImageListService())
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        _ = vc.view
        
        //then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testSetLike() {
        //given
        let vc = ImageListViewController()
        let presenter = ImageListPresenterSpy(imageListService: ImageListService())
        let photo = Photo(id: "123", size: CGSize(width: 400, height: 400), createdAt: Date(), welcomeDescription: "testDesc", thumbImageURL: "url1", largeImageURL: "url2", isLiked: false)
        let indexPath = IndexPath(row: 0, section: 0)
        
        let cell = ImageListCell()
        cell.delegate = vc
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        presenter.imageListCellDidTapLike(cell, indexPath: indexPath)
        
        //then
        XCTAssertTrue(presenter.changeLikeCalled)
    }
    
    func testTableViewUpdate() {
        //given
        let vc = ImageListViewController()
        let presenter = ImageListPresenterSpy(imageListService: ImageListService())
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        presenter.updateTableViewAnimation()
        
        //then
        XCTAssertTrue(presenter.tableViewUpdateCheck)
    }

}

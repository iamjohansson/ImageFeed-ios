import Foundation
@testable import ImageFeed_ios

final class WebViewViewControllerSpy: WebViewViewControllerProtocol {
    
    var loadRequestCalled = false
    var presenter: ImageFeed_ios.WebViewPresenterProtocol?
    
    func load(request: URLRequest) {
        loadRequestCalled = true
    }
    
    func setProgressValue(_ newValue: Float) {
        
    }
    
    func setProgressHidden(_ isHidden: Bool) {
        
    }
    

    
}


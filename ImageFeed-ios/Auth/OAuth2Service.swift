import Foundation

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private var lastCode: String?
    private (set) var authToken: String? {
        get {
            return OAuth2TokenStorage().token
        }
        set {
            OAuth2TokenStorage().token = newValue
        }
    }
    
    func fetchAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        guard lastCode != code else { return }
        task?.cancel()
        lastCode = code
        
        let request = authTokenRequest(code: code)
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<OAuthTokenResponseBody, Error>) in
            guard let self = self else { return }
            self.task = nil
            switch result {
            case .success(let body):
                let authToken = body.accessToken
                self.authToken = authToken
                completion(.success(authToken))
            case .failure(let error):
                self.lastCode = nil
                completion(.failure(error))
            }
        }
        self.task = task
        task.resume()
    }
    
    private func authTokenRequest(code: String) -> URLRequest {
        let url = URL(string: "https://unsplash.com/oauth/token")!
        let parameters = [
            "client_id": "\(AccessKey)",
            "client_secret": "\(SecretKey)",
            "redirect_uri": "\(RedirectURI)",
            "code": "\(code)",
            "grant_type": "authorization_code"
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parametersString = parameters.map { key, value in
            return "\(key)=\(value)"
        }.joined(separator: "&")
        request.httpBody = parametersString.data(using: .utf8)
        return request
    }
}




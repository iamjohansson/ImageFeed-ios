import Foundation

struct PhotoResult: Decodable {
    let id: String
    let createdAt: String?
    let width: Int?
    let height: Int?
    let isLiked: Bool?
    let welcomeDescription: String?
    let urls: UrlsResult?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case width = "width"
        case height = "height"
        case isLiked = "liked_by_user"
        case welcomeDescription = "description"
        case urls = "urls"
    }
}

struct UrlsResult: Decodable {
    let trumbImageURL: String?
    let largeImageURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case trumbImageURL = "thumb"
        case largeImageURL = "full"
    }
}

// Модель для UI кода

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String?
    let largeImageURL: String?
    let isLiked: Bool
    
    init(decoded: PhotoResult) {
        self.id = decoded.id
        self.size = CGSize(width: decoded.width ?? 0, height: decoded.height ?? 0)
        self.createdAt = dateFormatter.date(from: decoded.createdAt ?? "")
        self.welcomeDescription = decoded.welcomeDescription
        self.thumbImageURL = decoded.urls?.trumbImageURL
        self.largeImageURL = decoded.urls?.largeImageURL
        self.isLiked = decoded.isLiked ?? false
    }
    
}

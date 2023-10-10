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
}

// Модели для лайков

struct LikeResult: Decodable {
    let photo: PhotoResult?
}

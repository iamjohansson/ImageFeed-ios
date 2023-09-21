import Foundation

struct UserResult: Codable {
    let profileImage: ProfileImageSize
    
    private enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}
// Добавил large вместо small,  т.к. качество аватарки будет не ок
struct ProfileImageSize: Codable {
    let large: String
}

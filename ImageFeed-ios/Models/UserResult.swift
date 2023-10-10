import Foundation

struct UserResult: Codable {
    let profileImage: ProfileImageSize
    
    private enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}

struct ProfileImageSize: Codable {
    let large: String
}

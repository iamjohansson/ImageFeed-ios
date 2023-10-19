import Foundation

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String
    
    static var standart: AuthConfiguration {
        return AuthConfiguration(accessKey: "AuTnftee_Fj65fDYc8370UEC0X0DHuBqR2akpIh615Q",
                                 secretKey: "S0FL71uCoQBnU1U1uzgcBhLYerPaynaupO9w1lDLXCU",
                                 redirectURI: "urn:ietf:wg:oauth:2.0:oob",
                                 accessScope: "public+read_user+write_likes",
                                 defaultBaseURL: URL(string: "https://api.unsplash.com")!,
                                 authURLString: "https://unsplash.com/oauth/authorize")
    }
}

import Foundation

struct LoginModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data : [KakaoLoginDataModel]
}

// MARK: - DataModel
struct KakaoLoginDataModel: Codable {
    let code: String
}

struct KakaoLoginTokenModel: Codable {
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

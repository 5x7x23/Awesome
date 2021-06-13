import Foundation


struct LoginModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [KakaoLoginDataModel]
}

// MARK: - DataModel
struct KakaoLoginDataModel: Codable {
    let accesstoken: String
    let refreshtoken: String

    enum CodingKeys: String, CodingKey {
        case accesstoken = "access_token"
        case refreshtoken = "refresh_token"
    }
}

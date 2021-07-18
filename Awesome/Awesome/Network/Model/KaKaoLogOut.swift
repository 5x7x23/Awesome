import Foundation

// MARK: - AutoLoginDataModel
struct LogOutDataModel: Codable {
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

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

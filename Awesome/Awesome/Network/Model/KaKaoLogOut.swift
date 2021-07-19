import Foundation

// MARK: - LogoutDataModel
struct LogoutDataModel: Codable {
    let detail, code: String
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let tokenClass, tokenType, message: String

    enum CodingKeys: String, CodingKey {
        case tokenClass = "token_class"
        case tokenType = "token_type"
        case message
    }
}

import Foundation

// MARK: - LogoutDataModel
struct InviteCountDataModel: Codable {
    let invitations: [Invitation]
}

// MARK: - Invitation
struct Invitation: Codable {
    let invitationToken: String
    let isUsed: Bool

    enum CodingKeys: String, CodingKey {
        case invitationToken = "invitation_token"
        case isUsed = "is_used"
    }
}

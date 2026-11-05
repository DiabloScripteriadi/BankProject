import Foundation
import FirebaseFirestore

struct CardModel: Codable {
    let id: String?
    let last4: String
    let brand: String
    let paymentMethodId: String
    @ServerTimestamp var updatedAt: Timestamp?
}
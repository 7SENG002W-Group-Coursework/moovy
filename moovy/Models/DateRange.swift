
import Foundation

struct DateRange: Codable {
    let maximum: Date?
    let minimum: Date?

    enum CodingKeys: String, CodingKey {
        case maximum
        case minimum
    }
}

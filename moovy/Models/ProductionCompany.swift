
import Foundation

struct ProductionCompany: Codable {
    let id: Int
    let name, originCountry: String?
    let logoPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}



import Foundation

struct Network: Codable {
    let id: Int
    let name, logoPath, originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

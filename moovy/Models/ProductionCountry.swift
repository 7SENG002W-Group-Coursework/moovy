//
//  ProductionCountry.swift
//  moovy
//
//  Created by Anthony Gibah on 5/9/24.
//

import Foundation

struct ProductionCountry: Codable {
    let iso31661: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

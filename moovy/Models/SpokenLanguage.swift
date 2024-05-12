//
//  SpokenLanguage.swift
//  moovy
//
//  Created by Anthony Gibah on 5/9/24.
//

import Foundation

struct SpokenLanguage: Codable {
    let englishName, iso6391, name: String
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}

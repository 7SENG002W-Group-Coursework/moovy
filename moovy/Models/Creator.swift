//
//  Creator.swift
//  moovy
//
//  Created by Anthony Gibah on 5/9/24.
//

import Foundation

struct Creator: Codable {
    let id: Int
    let creditId, name, originalName: String
    let gender: Int
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, gender
        case creditId = "credit_id"
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}

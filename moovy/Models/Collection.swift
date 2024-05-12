//
//  MovieCollection.swift
//  moovy
//
//  Created by Anthony Gibah on 5/9/24.
//

import Foundation

struct Collection: Codable {
        let id: Int
        let name: String
        let posterPath: String
        let backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
}

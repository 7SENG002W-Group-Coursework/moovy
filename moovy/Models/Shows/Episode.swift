//
//  Episode.swift
//  moovy
//
//  Created by Anthony Gibah on 5/9/24.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name, overview: String
    let voteAverage: Double
    let voteCount, episodeNumber, seasonNumber: Int
    let airDate: String?
    let episodeType, productionCode: String?
    let runtime: Int?
    let showId: Int?
    let stillPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview, runtime, showId
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case episodeNumber = "episode_number"
        case seasonNumber = "season_number"
        case airDate = "air_date"
        case episodeType = "episode_type"
        case productionCode = "production_code"
        case stillPath = "still_path"
    }
}

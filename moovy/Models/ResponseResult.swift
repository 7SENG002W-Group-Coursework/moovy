//
//  Trending.swift
//  moovy
//
//  Created by Anthony Gibah on 5/9/24.
//

import Foundation

struct ResponseResult: Identifiable, Codable, Equatable {
    
    let id: Int
    let title: String?
    let name: String?
    let originalLanguage: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let mediaType: String?
    let adult: Bool
    let genreIds: [Int]
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Double

    enum CodingKeys: String, CodingKey {
        case id, overview, adult, popularity, video
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case mediaType = "media_type"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case title, name 
    }

    
    // Computed property to unify the title
    var unifiedTitle: String {
        return title ?? name ?? "Untitled"
    }
}

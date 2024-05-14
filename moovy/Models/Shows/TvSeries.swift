

import Foundation

struct TvSeries: Codable {
    
    let adult: Bool?
    let backdropPath: String?
    let createdBy: [Creator]
    let episodeRunTime: [Int]
    let firstAirDate: String?
    let genreIds: [Int]?
    let genres: [Genre]
    let homePage: String?
    let id: Int
    let inProduction: Bool
    let languages: [String]
    let lastAirDate: String?
    let lastEpisodeToAir: Episode?
    let name: String
    let networks: [Network]
    let nextEpisodeToAir: Episode?
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let originCountry: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let seasons: [Season]
    let spokenLanguages: [SpokenLanguage]
    let status: String
    let tagline: String?
    let type: String
    let voteAverage: Double
    let voteCount: Int

    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres
        case genreIds = "genre_ids"
        case homePage = "homepage"
        case id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case networks
        case nextEpisodeToAir = "next_episode_to_air"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

}

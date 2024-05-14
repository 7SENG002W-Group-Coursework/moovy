
import Foundation
struct Movie: Identifiable, Codable {
    
    let adult: Bool?
        let backdropPath: String?
        let belongsToCollection: Collection?
        let budget: Int?
        let description: String?
        let genre: String?
        let genreIds: [Int]?
        let genres: [Genre]?
        let homePage: String?
        let id: Int
        let imdbId: String?
        let logo: String?
        let originCountry: [String]?
        let originalLanguage: String?
        let originalTitle: String?
        let overview: String?
        let popularity: Double?
        let posterPath: String?
        let productionCompanies: [ProductionCompany]?
        let productionCountries: [ProductionCountry]?
        let rating: Double?
        let releaseDate: String?
        let releaseYear: String?
        let revenue: Int?
        let runtime: Int?
        let spokenLanguages: [SpokenLanguage]?
        let status: String?
        let tagline: String?
        let title: String
        let video: Bool?
        let voteAverage: Double?
        let voteCount: Int?
        
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case belongsToCollection = "belongs_to_collection"
            case budget
            case description
            case genre
            case genreIds = "genre_ids"
            case genres
            case homePage = "homepage"
            case id
            case imdbId = "imdb_id"
            case logo
            case originCountry = "origin_country"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview
            case popularity
            case posterPath = "poster_path"
            case productionCompanies = "production_companies"
            case productionCountries = "production_countries"
            case rating
            case releaseDate = "release_date"
            case releaseYear
            case revenue
            case runtime
            case spokenLanguages = "spoken_languages"
            case status
            case tagline
            case title
            case video
            case voteAverage = "vote_average"
            case voteCount
        }
}

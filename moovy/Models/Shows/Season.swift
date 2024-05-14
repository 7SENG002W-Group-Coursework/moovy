
import Foundation

struct Season: Codable {
    let airDate: String?
    let episodeCount: Int
    let id: Int
    let name, overview: String
    let posterPath: String?
    let seasonNumber: Int
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}

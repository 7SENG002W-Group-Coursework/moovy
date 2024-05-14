

import Foundation

struct BaseApi {
    static let imageUrl: String = "https://image.tmdb.org/t/p/w500"
    static let apiKey: String =  "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjkwOGZmOWUyMGUzY2YyNGRjMjYwZTgxNDAwMDAwZSIsInN1YiI6IjY2MDg4YTA2YTZkZGNiMDE2MzQ2MDExYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tNheQvdvxRzR1NDHPMsVWz-3W6ijpGueBsSYq1TRbB4"
    
    //Home Urls
    static let allTrendingUrl: String = "https://api.themoviedb.org/3/trending/all/day?language=en-US"
    static let moviesTrendingUrl: String = "https://api.themoviedb.org/3/trending/movie/day?language=en-US"
    static let moviesNowPlayingUrl: String = "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1&region=GB"
    static let moviesUpcomingUrl: String = "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1"
    static let moviesTopRatedUrl: String = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1"
    static let moviesPopularUrl: String = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=2"
    static let showsTopRatedUrl: String = "https://api.themoviedb.org/3/tv/top_rated?language=en-US&page=1"
    static let showsTrendingUrl: String = "https://api.themoviedb.org/3/trending/tv/day?language=en-US"
    static let showsPopularUrl: String = "https://api.themoviedb.org/3/tv/popular?language=en-US&page=1"
    
    //Search Urls
    static let baseMoviesSearchUrl: String = "https://api.themoviedb.org/3/search/movie"
    static let baseShowsSearchUrl: String = "https://api.themoviedb.org/3/search/tv"
    
    static let tvGenre: String = "https://api.themoviedb.org/3/genre/tv/list"
    
    static let movieGenre: String = "https://api.themoviedb.org/3/genre/movie/list"
    
    //MovieDetails
    static let movieDetails: String = "https://api.themoviedb.org/3/movie"
    
    //ShowDetails
    static let showDetails: String = "https://api.themoviedb.org/3/tv"
}

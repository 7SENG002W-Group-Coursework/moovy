//
//  HomeViewModel.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//

import Foundation
import UIKit
import Combine

class HomeViewModel: ObservableObject {
    @Published var allTrending: [ResponseResult] = []
    @Published var showsTrending: [ResponseResult] = []
    @Published var showsTopRated: [ResponseResult] = []
    @Published var showsPopular: [ResponseResult] = []
    @Published var moviesTrending: [ResponseResult] = []
    @Published var moviesNowPlaying: [ResponseResult] = []
    @Published var moviesUpcoming: [ResponseResult] = []
    @Published var moviesTopRated: [ResponseResult] = []
    @Published var moviesPopular: [ResponseResult] = []
    @Published var moviesTrendingSmallDisplay: [SmallDisplay] = []
    @Published var moviesNowPlayingSmallDisplay: [SmallDisplay] = []
    @Published var moviesUpcomingSmallDisplay: [SmallDisplay] = []
    @Published var moviesTopRatedSmallDisplay: [SmallDisplay] = []
    @Published var moviesPopularSmallDisplay: [SmallDisplay] = []
    @Published var showsTopRatedSmallDisplay: [SmallDisplay] = []
    @Published var showsTrendingSmallDisplay: [SmallDisplay] = []
    @Published var showsPopularSmallDisplay: [SmallDisplay] = []
    @Published var posterPathImage: UIImage? = nil
    @Published var errorOccurred: Bool = false
    @Published var errorMessage: String = ""
    var cancellables = Set<AnyCancellable>()
    
    
    private let allTrendingURLString = "\(BaseApi.allTrendingUrl)"
    private let moviesTrendingURLString = "\(BaseApi.moviesTrendingUrl)"
    private let moviesNowPlayingURLString = "\(BaseApi.moviesNowPlayingUrl)"
    private let moviesUpcomingURLString = "\(BaseApi.moviesUpcomingUrl)"
    private let moviesTopRatedURLString = "\(BaseApi.moviesTopRatedUrl)"
    private let moviesPopularURLString = "\(BaseApi.moviesPopularUrl)"
    private let showsTopRatedURLString = "\(BaseApi.showsTopRatedUrl)"
    private let showsTrendingURLString = "\(BaseApi.showsTrendingUrl)"
    private let showsPopularURLString = "\(BaseApi.showsPopularUrl)"
    private let token = "\(BaseApi.apiKey)"
    
    init(){
        Task {
            await fetchAllTrending()
            await fetchShowsTrending()
            await fetchShowsTopRated()
            await fetchShowsPopular()
            await fetchMoviesTrending()
            await fetchMoviesNowPlaying()
            await fetchMoviesUpcoming()
            await fetchMoviesTopRated()
            await fetchMoviesPopular()
        }
    }
    
    func fetchAllTrending() async {
        guard let url = URL(string: allTrendingURLString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to fetch data: HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                DispatchQueue.main.async {
                    self.errorOccurred = true
                    self.errorMessage = "Failed to load trending movies"
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatterUtils.moovyDateFormat)
            let decodedData = try decoder.decode(ResponseData<ResponseResult>.self, from: data)
            
            DispatchQueue.main.async {
                self.allTrending = decodedData.results
                // Print the decoded data to check structure
                //                print("Decoded data: \(self.allTrending)")
                self.errorOccurred = false
                self.errorMessage = ""
            }
        } catch {
            print("Error fetching trending: \(error)")
            DispatchQueue.main.async {
                self.errorOccurred = true
                self.errorMessage = "Error fetching trending movies and shows"
            }
        }
    }
    
    func fetchMoviesTopRated() async {
        guard let url = URL(string: moviesTopRatedURLString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to fetch data: HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                DispatchQueue.main.async {
                    self.errorOccurred = true
                    self.errorMessage = "Failed to load top rated movies"
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatterUtils.moovyDateFormat)
            let decodedData = try decoder.decode(ResponseData<ResponseResult>.self, from: data)
            
            DispatchQueue.main.async {
                self.moviesTopRated = decodedData.results
                let smallDisplay = decodedData.results.map { trending -> SmallDisplay in
                    SmallDisplay(id: trending.id, posterPath: trending.posterPath)
                }
                self.moviesTopRatedSmallDisplay = smallDisplay
                // Print the decoded data to check structure
                //                print("Decoded data: \(self.allTrending)")
                self.errorOccurred = false
                self.errorMessage = ""
            }
        } catch {
            print("Error fetching top rated: \(error)")
            DispatchQueue.main.async {
                self.errorOccurred = true
                self.errorMessage = "Error fetching top rated movies"
            }
        }
    }
    
    func fetchMoviesPopular() async {
        guard let url = URL(string: moviesPopularURLString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to fetch data: HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                DispatchQueue.main.async {
                    self.errorOccurred = true
                    self.errorMessage = "Failed to load popular movies"
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatterUtils.moovyDateFormat)
            let decodedData = try decoder.decode(ResponseData<ResponseResult>.self, from: data)
            
            DispatchQueue.main.async {
                self.moviesPopular = decodedData.results
                let smallDisplay = decodedData.results.map { trending -> SmallDisplay in
                    SmallDisplay(id: trending.id, posterPath: trending.posterPath)
                }
                self.moviesPopularSmallDisplay = smallDisplay
                // Print the decoded data to check structure
                //                print("Decoded data: \(self.allTrending)")
                self.errorOccurred = false
                self.errorMessage = ""
            }
        } catch {
            print("Error fetching popular: \(error)")
            DispatchQueue.main.async {
                self.errorOccurred = true
                self.errorMessage = "Error fetching popular movies"
            }
        }
    }
    
    func fetchMoviesTrending() async {
        guard let url = URL(string: moviesTrendingURLString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to fetch data: HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                DispatchQueue.main.async {
                    self.errorOccurred = true
                    self.errorMessage = "Failed to load trending movies"
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatterUtils.moovyDateFormat)
            let decodedData = try decoder.decode(ResponseData<ResponseResult>.self, from: data)
            
            DispatchQueue.main.async {
                self.moviesTrending = decodedData.results
                let smallDisplay = decodedData.results.map { trending -> SmallDisplay in
                    SmallDisplay(id: trending.id, posterPath: trending.posterPath)
                }
                self.moviesTrendingSmallDisplay = smallDisplay
                // Print the decoded data to check structure
                //                print("Decoded data: \(self.allTrending)")
                self.errorOccurred = false
                self.errorMessage = ""
            }
        } catch {
            print("Error fetching trending movies: \(error)")
            DispatchQueue.main.async {
                self.errorOccurred = true
                self.errorMessage = "Error fetching trending movies"
            }
        }
    }
    
    func fetchMoviesUpcoming() async {
        guard let url = URL(string: moviesUpcomingURLString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to fetch data: HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                DispatchQueue.main.async {
                    self.errorOccurred = true
                    self.errorMessage = "Failed to load upcoming movies"
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatterUtils.moovyDateFormat)
            
            let decodedData = try decoder.decode(ResponseData<ResponseResult>.self, from: data)
            
            DispatchQueue.main.async {
                self.moviesUpcoming = decodedData.results
                let smallDisplay = decodedData.results.map { trending -> SmallDisplay in
                    SmallDisplay(id: trending.id, posterPath: trending.posterPath)
                }
                self.moviesUpcomingSmallDisplay = smallDisplay
                // Print the decoded data to check structure
                //                print("Decoded data: \(self.allTrending)")
                self.errorOccurred = false
                self.errorMessage = ""
            }
        } catch {
            print("Error fetching upcoming: \(error)")
            DispatchQueue.main.async {
                self.errorOccurred = true
                self.errorMessage = "Error fetching upcoming movies"
            }
        }
    }
    
    func fetchMoviesNowPlaying() async {
        guard let url = URL(string: moviesNowPlayingURLString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to fetch data: HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                DispatchQueue.main.async {
                    self.errorOccurred = true
                    self.errorMessage = "Failed to load now playing movies"
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatterUtils.moovyDateFormat)
            
            let decodedData = try decoder.decode(ResponseData<ResponseResult>.self, from: data)
            
            DispatchQueue.main.async {
                self.moviesNowPlaying = decodedData.results
                let smallDisplay = decodedData.results.map { trending -> SmallDisplay in
                    SmallDisplay(id: trending.id, posterPath: trending.posterPath)
                }
                self.moviesNowPlayingSmallDisplay = smallDisplay
                self.errorOccurred = false
                self.errorMessage = ""
            }
        } catch {
            print("Error fetching now playing movies: \(error)")
            DispatchQueue.main.async {
                self.errorOccurred = true
                self.errorMessage = "Error fetching now playing movies"
            }
        }
    }
    
    func fetchShowsTrending() async {
        guard let url = URL(string: showsTrendingURLString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to fetch data: HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                DispatchQueue.main.async {
                    self.errorOccurred = true
                    self.errorMessage = "Failed to load trending shows"
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatterUtils.moovyDateFormat)
            let decodedData = try decoder.decode(ResponseData<ResponseResult>.self, from: data)
            
            DispatchQueue.main.async {
                self.showsTrending = decodedData.results
                let smallDisplay = decodedData.results.map { trending -> SmallDisplay in
                    SmallDisplay(id: trending.id, posterPath: trending.posterPath)
                }
                self.showsTrendingSmallDisplay = smallDisplay
                // Print the decoded data to check structure
                //                print("Decoded data: \(self.allTrending)")
                self.errorOccurred = false
                self.errorMessage = ""
            }
        } catch {
            print("Error fetching trending shows: \(error)")
            DispatchQueue.main.async {
                self.errorOccurred = true
                self.errorMessage = "Error fetching trending shows"
            }
        }
    }
    
    func fetchShowsTopRated() async {
        guard let url = URL(string: showsTopRatedURLString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to fetch data: HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                DispatchQueue.main.async {
                    self.errorOccurred = true
                    self.errorMessage = "Failed to load top rated shows"
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatterUtils.moovyDateFormat)
            let decodedData = try decoder.decode(ResponseData<ResponseResult>.self, from: data)
            
            DispatchQueue.main.async {
                self.showsTopRated = decodedData.results
                let smallDisplay = decodedData.results.map { trending -> SmallDisplay in
                    SmallDisplay(id: trending.id, posterPath: trending.posterPath)
                }
                self.showsTopRatedSmallDisplay = smallDisplay
                // Print the decoded data to check structure
                //                print("Decoded data: \(self.allTrending)")
                self.errorOccurred = false
                self.errorMessage = ""
            }
        } catch {
            print("Error fetching top rated: \(error)")
            DispatchQueue.main.async {
                self.errorOccurred = true
                self.errorMessage = "Error fetching top rated shows"
            }
        }
    }
    
    func fetchShowsPopular() async {
        guard let url = URL(string: showsPopularURLString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to fetch data: HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                DispatchQueue.main.async {
                    self.errorOccurred = true
                    self.errorMessage = "Failed to load popular shows"
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatterUtils.moovyDateFormat)
            let decodedData = try decoder.decode(ResponseData<ResponseResult>.self, from: data)
            
            DispatchQueue.main.async {
                self.showsPopular = decodedData.results
                let smallDisplay = decodedData.results.map { trending -> SmallDisplay in
                    SmallDisplay(id: trending.id, posterPath: trending.posterPath)
                }
                self.showsPopularSmallDisplay = smallDisplay
                // Print the decoded data to check structure
                //                print("Decoded data: \(self.allTrending)")
                self.errorOccurred = false
                self.errorMessage = ""
            }
        } catch {
            print("Error fetching popular: \(error)")
            DispatchQueue.main.async {
                self.errorOccurred = true
                self.errorMessage = "Error fetching popular shows"
            }
        }
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: BaseApi.imageUrl + urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.posterPathImage = $0 }
            .store(in: &cancellables)
    }
}

//
//  SearchViewModel.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//

import Foundation
import UIKit
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchMovie: [ResponseResult] = []
    @Published var searchShow: [ResponseResult] = []
    @Published var searchMovieRowData: [HorizonalDisplayItem] = []
    @Published var searchShowRowData: [HorizonalDisplayItem] = []
    @Published var posterPathImage: UIImage? = nil
    @Published var errorOccurred: Bool = false
    @Published var errorMessage: String = ""
    @Published var genreName: String = ""
    var cancellables = Set<AnyCancellable>()
    
    private let token = "\(BaseApi.apiKey)"
    private let baseMoviesSearchURLString = "\(BaseApi.baseMoviesSearchUrl)"
    private let baseShowsSearchURLString = "\(BaseApi.baseShowsSearchUrl)"
    
    init(){
        Task {
            await fetchMoviesSearch(query: "dune")
            await fetchShowsSearch(query: "a")
        }
    }
    
//    func fetchAllSearch(query: String)async {
//    }
    
    func fetchMoviesSearch(query: String)async {
            guard var components = URLComponents(string: baseMoviesSearchURLString) else {
                print("Invalid URL")
                return
            }
            
            // Add query items
            components.queryItems = [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "include_adult", value: "true"),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1")
            ]
            
            // Validate the final URL
            guard let url = components.url else {
                print("Invalid URL with components")
                return
            }
            
            // Prepare the URLRequest
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
                    self.searchMovie = decodedData.results
                    let searchItemRow = decodedData.results.map { item -> HorizonalDisplayItem in
                        HorizonalDisplayItem(id: item.id, title: item.title, name: item.name, rating: item.voteAverage, genreIds: item.genreIds, posterPath: item.posterPath, releaseDate: item.releaseDate, mediaType: item.mediaType)
                    }
                    self.searchMovieRowData = searchItemRow
                    // Update UI or process data
                    self.errorOccurred = false
                    self.errorMessage = ""
                }
                
            } catch {
                print("Error fetching search items: \(error)")
                DispatchQueue.main.async {
                    self.errorOccurred = true
                    self.errorMessage = "Error fetching search items"
                }
            }
        }
    
    func fetchShowsSearch(query: String) async {
        guard var components = URLComponents(string: baseShowsSearchURLString) else {
            print("Invalid URL")
            return
        }
        
        // Add query items
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "include_adult", value: "true"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        // Validate the final URL
        guard let url = components.url else {
            print("Invalid URL with components")
            return
        }
        
        // Prepare the URLRequest
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
                self.searchShow = decodedData.results
                let searchItemRow = decodedData.results.map { item -> HorizonalDisplayItem in
                    HorizonalDisplayItem(id: item.id, title: item.title, name: item.name, rating: item.voteAverage, genreIds: item.genreIds, posterPath: item.posterPath, releaseDate: item.releaseDate, mediaType: item.mediaType)
                }
                self.searchShowRowData = searchItemRow
                // Update UI or process data
                self.errorOccurred = false
                self.errorMessage = ""
            }
            
        } catch {
            print("Error fetching search items: \(error)")
            DispatchQueue.main.async {
                self.errorOccurred = true
                self.errorMessage = "Error fetching search items"
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
    
    func fetchGenreName(genreIds: [Int], mediaType: String) {
        guard let firstGenreId = genreIds.first else {
            DispatchQueue.main.async {
                self.genreName = "Genre not found"
            }
            return
        }
        
        Task {
            let fetchedGenreName = await getShowGenre(id: firstGenreId, mediaType: mediaType)
            DispatchQueue.main.async {
                self.genreName = fetchedGenreName ?? "Genre not found"
            }
        }
    }
    
    func getShowGenre(id: Int, mediaType: String) async -> String? {
        let baseUrl = mediaType == "tv" ? BaseApi.tvGenre : BaseApi.movieGenre
        guard let components = URLComponents(string: baseUrl) else {
            print("Invalid URL")
            return nil
        }
        
        // Add query items
        var updatedComponents = components
        updatedComponents.queryItems = [
            URLQueryItem(name: "language", value: "en")
        ]
        
        // Validate the final URL
        guard let url = updatedComponents.url else {
            print("Invalid URL with components")
            return nil
        }
        
        // Prepare the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to fetch data: HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                return nil
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatterUtils.moovyDateFormat)
            let decodedData = try decoder.decode(GenresResponseData.self, from: data)
            
            // No need for DispatchQueue.main.async since no UI updates are done here
            for genre in decodedData.genres {
                if genre.id == id {
                    return genre.name
                }
            }
            // If no genre is found, return nil
            return nil
        } catch {
            print("Error fetching genres: \(error)")
            return nil
        }
    }
    

}





import Foundation
import UIKit
import Combine
import FirebaseFirestore
import FirebaseAuth

class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: Movie?
    @Published var posterPathImage: UIImage? = nil
    @Published var backdropPathImage: UIImage? = nil
    @Published var posterImage: UIImage? = nil
    @Published var errorOccurred: Bool = false
    @Published var errorMessage: String = ""
    @Published var genreName: String = ""
    var cancellables = Set<AnyCancellable>()
    
    private let movieDetailsURLString = "\(BaseApi.movieDetails)"
    private let token = "\(BaseApi.apiKey)"
    
    
    @Published var movieIsBookmarked: Bool = false
    let db = Firestore.firestore()
    
    func addMovieToWatchlist(onComplete: @escaping (_ error: String?) -> Void) async{
        
        let uid = Auth.auth().currentUser!.uid
        let movieDb = movieDetails
        
        do {
            try db.collection("users")
                .document(uid)
                .collection("movie_watchlist")
                .document(String(movieDetails!.id))
                .setData(from: movieDb)
            print("Document successfully written!")
            onComplete(nil)
        } catch let error {
            print("Error writing document: \(error)")
            onComplete("\(error)")
        }
    } 
    
    func deleteMovieFromWatchlist(onComplete: @escaping (_ error: String?) -> Void) async{
        
        let uid = Auth.auth().currentUser!.uid
        do {
            try await db.collection("users")
                .document(uid)
                .collection("movie_watchlist")
                .document(String(movieDetails!.id))
                .delete()
            print("Document successfully removed!")
            onComplete(nil)
        } catch let error {
            print("Error removing document: \(error)")
            onComplete("\(error)")
        }
    }
    
    func checkBookMarked() {
        guard let uid = Auth.auth().currentUser?.uid, let movieID = movieDetails?.id else {
            DispatchQueue.main.async {
                self.errorMessage = "Error: User not logged in or movie details missing"
            }
            return
        }

        db.collection("users").document(uid)
          .collection("movie_watchlist").document(String(movieID))
          .addSnapshotListener { [weak self] documentSnapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error fetching document: \(error.localizedDescription)"
                }
                return
            }
            
            guard let document = documentSnapshot else {
                DispatchQueue.main.async {
                    self.errorMessage = "Error: Document snapshot is nil"
                }
                return
            }
            
            DispatchQueue.main.async {
                self.movieIsBookmarked = document.exists
            }
        }
    }

    
    func fetchMovieDetails(movieId: Int, completion: @escaping () -> Void) async {
        guard var components = URLComponents(string: movieDetailsURLString) else {
            print("Invalid URL")
            return
        }
        
        // Append the movie ID to the path
        components.path.append("/\(movieId)")
        
        // Add query items
        components.queryItems = [
            URLQueryItem(name: "include_adult", value: "true")
        ]
        
        // Validate the final URL
        guard let url = components.url else {
            print("Invalid URL with components")
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
            let decodedData = try decoder.decode(Movie.self, from: data)
            
            DispatchQueue.main.async {
                self.movieDetails = decodedData
                self.errorOccurred = false
                self.errorMessage = ""
                completion()
            }
        } catch {
            print("Error fetching trending: \(error)")
            DispatchQueue.main.async {
                self.errorOccurred = true
                self.errorMessage = "Error fetching trending movies and shows"
                completion()
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
    
    func loadImagePosterImage(from urlString: String) async {
        guard let url = URL(string: BaseApi.imageUrl + urlString) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.posterImage = image
                }
            }
        } catch {
            print("Error loading image: \(error)")
        }
    }
    
    func loadImageBackdropImage(from urlString: String) async {
        guard let url = URL(string: BaseApi.imageUrl + urlString) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.backdropPathImage = image
                }
            }
        } catch {
            print("Error loading image: \(error)")
        }
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


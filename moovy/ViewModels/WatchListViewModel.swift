
import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class WatchListViewModel: ObservableObject {
    @Published var movieWatchList: [Movie] = []
    @Published var showWatchList: [TvSeries] = []
    @Published var movieWatchListH: [HorizonalDisplayItem] = []
    @Published var showWatchListH: [HorizonalDisplayItem] = []
    @Published var loading: Bool = false
    @Published var errorMessage: String = ""
    let db = Firestore.firestore()
    var uid: String? = Auth.auth().currentUser?.uid
    var cancellables = Set<AnyCancellable>()

    func fetchMoviesFromWatchlist(onComplete: ((_ error: Error?) -> Void)? = nil) async {
        guard let uid = uid else {
            print("UID is nil")
            onComplete?(NSError(domain: "AppErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID is undefined"]))
            return
        }

        do {
            let querySnapshot = try await db.collection("users")
                                            .document(uid)
                                            .collection("movie_watchlist")
                                            .getDocuments()
            var movies: [Movie] = []
            var movieHorizontal: [HorizonalDisplayItem] = []
            for document in querySnapshot.documents {
                guard let movie = try? document.data(as: Movie.self) else {
                    print("Error decoding document: \(document.documentID)")
                    continue
                }
                movies.append(movie)
                movieHorizontal.append(HorizonalDisplayItem(id: movie.id, title: movie.title, name: movie.title, rating: movie.rating, genreIds: movie.genreIds ?? [], posterPath: movie.posterPath, releaseDate: movie.releaseDate, mediaType: "Movie"))
            }
            self.movieWatchList = movies
            self.movieWatchListH = movieHorizontal
            onComplete?(nil)
        } catch {
            print("Error processing documents: \(error)")
            onComplete?(error)
        }
    }


    func fetchShowsFromWatchlist(onComplete: ((_ error: Error?) -> Void)? = nil) async {
        guard let uid = uid else {
            print("UID is nil")
            onComplete?(NSError(domain: "AppErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID is undefined"]))
            return
        }

        do {
            let querySnapshot = try await db.collection("users")
                                            .document(uid)
                                            .collection("show_watchlist")
                                            .getDocuments()
            var shows: [TvSeries] = []
            var showHorizontal: [HorizonalDisplayItem] = []
            for document in querySnapshot.documents {
                guard let show = try? document.data(as: TvSeries.self) else {
                    print("Error decoding document: \(document.documentID)")
                    continue
                }
                shows.append(show)
                showHorizontal.append(HorizonalDisplayItem(id: show.id, title: show.name, name: show.name, rating: show.voteAverage, genreIds: show.genreIds ?? [18], posterPath: show.posterPath, releaseDate: nil, mediaType: "Tv Show"))
            }
            self.showWatchList = shows
            self.showWatchListH = showHorizontal
            onComplete?(nil)
        } catch {
            print("Error processing documents: \(error)")
            onComplete?(error)
        }
    }


    
}

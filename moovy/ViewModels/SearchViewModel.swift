//
//  SearchViewModel.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    func getSearchResults() -> [Movie] {
        return [
//            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139"),
//            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139"),
//            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139"),
//            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139"),
//            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139"),
//            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139")
        ]
    }
    
    func getSearchDefaults() -> [Movie] {
        return [
            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139"),
            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139"),
            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139"),
            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139"),
            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139"),
            Movie(title: "Jurassic", logo: "Jurassic", rating: 9.5, genre: "Action", releaseYear: "2019", runtime: "139")
        ]
    }
}

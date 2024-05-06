//
//  HomeViewModel.swift
//  moovy
//
//  Created by Anthony Gibah on 5/6/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    func getTopMovies() -> [Movie] {
        return [
            Movie(movieName: "Jurassic", logo: "Jurassic"),
            Movie(movieName: "Jurassic", logo: "Jurassic"),
            Movie(movieName: "Jurassic", logo: "Jurassic"),
            Movie(movieName: "Jurassic", logo: "Jurassic"),
            Movie(movieName: "Jurassic", logo: "Jurassic")
        ]
    }
    func getMovies() -> [Movie] {
        return [
            Movie(movieName: "Jurassic", logo: "Jurassic"),
            Movie(movieName: "Jurassic", logo: "Jurassic"),
            Movie(movieName: "Jurassic", logo: "Jurassic"),
            Movie(movieName: "Jurassic", logo: "Jurassic"),
            Movie(movieName: "Jurassic", logo: "Jurassic")
        ]
    }
}

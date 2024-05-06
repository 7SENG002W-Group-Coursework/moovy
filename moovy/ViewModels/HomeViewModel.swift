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
            Movie(title: "Jurassic", logo: "Jurassic"),
            Movie(title: "Jurassic", logo: "Jurassic"),
            Movie(title: "Jurassic", logo: "Jurassic"),
            Movie(title: "Jurassic", logo: "Jurassic"),
            Movie(title: "Jurassic", logo: "Jurassic")
        ]
    }
    func getMovies() -> [Movie] {
        return [
            Movie(title: "Jurassic", logo: "Jurassic"),
            Movie(title: "Jurassic", logo: "Jurassic"),
            Movie(title: "Jurassic", logo: "Jurassic"),
            Movie(title: "Jurassic", logo: "Jurassic"),
            Movie(title: "Jurassic", logo: "Jurassic")
        ]
    }
}

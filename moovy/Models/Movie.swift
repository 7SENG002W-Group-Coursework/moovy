//
//  Movie.swift
//  moovy
//
//  Created by Anthony Gibah on 5/5/24.
//
import Foundation
struct Movie: Identifiable{
    let id = UUID()  // Use UUID directly in the struct
    let title: String
    let rating: Double?
    let genre: String?
    let releaseYear: String?
    let runtime: String?
    let logo: String
    
    init(title: String, logo: String, rating: Double? = nil, genre: String? = nil, releaseYear: String? = nil, runtime: String? = nil) {
            self.title = title
            self.logo = logo
            self.rating = rating
            self.genre = genre
            self.releaseYear = releaseYear
            self.runtime = runtime
        }
}

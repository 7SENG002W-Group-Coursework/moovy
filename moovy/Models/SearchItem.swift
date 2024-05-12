//
//  SearchItem.swift
//  moovy
//
//  Created by Anthony Gibah on 5/10/24.
//

import Foundation
struct SearchItem {
    
    let id: Int
    let title: String? // For movies
    let name: String?
    let rating: Double?
    let genreIds: [Int]
    let posterPath: String?
    let releaseDate: String?
    let mediaType: String?
    
}

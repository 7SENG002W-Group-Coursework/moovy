//
//  Movie.swift
//  moovy
//
//  Created by Anthony Gibah on 5/5/24.
//
import Foundation
struct Movie: Identifiable{
    let id = UUID()  // Use UUID directly in the struct
    let movieName: String
    let logo: String
}

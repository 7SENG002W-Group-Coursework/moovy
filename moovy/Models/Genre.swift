//
//  Genre.swift
//  moovy
//
//  Created by Anthony Gibah on 5/9/24.
//

import Foundation

struct Genre: Codable{
    let id: Int
    let name: String?
    
    init(
        id: Int,
        name: String? = nil
    ) {
            self.id = id
            self.name = name
        }
}

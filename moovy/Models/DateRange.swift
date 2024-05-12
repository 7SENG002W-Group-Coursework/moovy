//
//  DateData.swift
//  moovy
//
//  Created by Anthony Gibah on 5/9/24.
//

import Foundation

struct DateRange: Codable {
    let maximum: Date?
    let minimum: Date?

    enum CodingKeys: String, CodingKey {
        case maximum
        case minimum
    }
}

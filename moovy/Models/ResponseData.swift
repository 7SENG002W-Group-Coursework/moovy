//
//  TrendingResponse.swift
//  moovy
//
//  Created by Anthony Gibah on 5/9/24.
//

import Foundation
struct ResponseData<T: Codable>: Codable {
    let page: Int
    let results: [T]
    let dates: DateRange?
}

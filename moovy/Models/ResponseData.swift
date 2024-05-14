
import Foundation
struct ResponseData<T: Codable>: Codable {
    let page: Int
    let results: [T]
    let dates: DateRange?
}

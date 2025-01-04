import Foundation

// using decodable instead of codable as we are only ever going to decode data and never encode data.
struct WeatherResponseModel: Decodable {
    let name: String
    let main: WeatherModel
}

struct WeatherModel: Decodable {
    let temp: Double
    let humidity: Double
}

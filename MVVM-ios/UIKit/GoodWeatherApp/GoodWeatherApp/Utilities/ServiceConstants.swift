import Foundation

struct ServiceConstants {
    struct URLs {
        static func urlForWeatherByCity(city: String) -> URL? {
            let apiKey = "2606fe58e24e8563abe8f9d92195a5dc"
            let unit = (UserDefaults.standard.value(forKey: "unit") as? String) ?? "metric"
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=\(unit)")
        }
    }
}

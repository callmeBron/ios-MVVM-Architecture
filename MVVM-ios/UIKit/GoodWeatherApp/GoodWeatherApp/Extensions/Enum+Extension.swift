import Foundation

extension WeatherUnit {
    var displayName: String {
        get {
            switch self {
                case .farenheit:
                return "Fahrenheit"
            case .celsius:
                return "Celsius"
            }
        }
    }
    
    var abbreviation: String {
        get {
            switch self {
            case .farenheit:
                return "F"
            case .celsius:
                return "C"
            }
        }
    }
}

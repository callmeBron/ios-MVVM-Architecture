import Foundation

enum WeatherUnit: String, CaseIterable {
    case farenheit = "imperial"
    case celsius = "metric"
}

class SettingsViewModel {
    let userDefault = UserDefaults.standard
    let units = WeatherUnit.allCases
    
    var selectedUnit: WeatherUnit {
        get {
            var unit = ""
            if let value = self.userDefault.string(forKey: "unit") {
                unit = value
            }
            return WeatherUnit(rawValue: unit) ?? .celsius
        }
        set {
            self.userDefault.set(newValue.rawValue, forKey: "unit")
        }
    }
}

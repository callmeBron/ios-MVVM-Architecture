import Foundation

class WeatherViewModel {
    let weather: WeatherResponseModel
    var cityTemperature: Double
    
    var cityName: String {
        return weather.name
    }
    
    init(weather: WeatherResponseModel) {
        self.weather = weather
        self.cityTemperature = weather.main.temp
    }

}

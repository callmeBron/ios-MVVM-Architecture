import Foundation

class WeatherListViewModel {
    var savedCities: [WeatherViewModel] = []
    
    func addWeatherViewModel(_ viewModel: WeatherViewModel){
        savedCities.append(viewModel)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        savedCities.count
    }
    
    func cityModel(at index: Int) -> WeatherViewModel {
        return savedCities[index]
    }
    
    func updateUnit(with unit: WeatherUnit) {
        switch unit {
        case .farenheit:
            toFarenheit()
        case .celsius:
            toCelsius()
        }
    }
    
    func toCelsius() {
        savedCities =  savedCities.map { viewModel in
            let weatherViewModel = viewModel
            weatherViewModel.cityTemperature = (weatherViewModel.cityTemperature - 32) * 5/9
            return weatherViewModel
        }
    }
    
    func toFarenheit() {
        savedCities =  savedCities.map { viewModel in
            let weatherViewModel = viewModel
            weatherViewModel.cityTemperature = (weatherViewModel.cityTemperature  * 9/5) + 32
            return weatherViewModel
        }
    }
}



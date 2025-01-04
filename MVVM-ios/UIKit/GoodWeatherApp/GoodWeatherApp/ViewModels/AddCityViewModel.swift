import Foundation

class AddCityViewModel {
    private let webService: WebService
    
    init() {
        self.webService = WebService()
    }
    
    func addWeather(for city: String, completion: @escaping (WeatherViewModel) -> Void) {
        guard let weatherURL = ServiceConstants.URLs.urlForWeatherByCity(city: city) else { fatalError("URL issue") }
        let weatherResource = Resource<WeatherResponseModel>(url: weatherURL) { data in
            guard let decodedResponse = try? JSONDecoder().decode(WeatherResponseModel.self, from: data) else { fatalError("issue decoding data") }
            return decodedResponse
        }
        
        webService.load(resource: weatherResource) { result in
            if let result {
                completion(WeatherViewModel(weather: result))
            }
        }
    }
}

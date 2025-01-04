import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(_ weatherViewModel: WeatherViewModel)
}
class AddCityViewController: UIViewController {
    @IBOutlet weak var citySearchTextField: UITextField!
    private let viewModel = AddCityViewModel()
    
    var delegate: AddWeatherDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTextField()
    }
    
    private func setupTextField() {
        citySearchTextField.placeholder = "Find a city..."
    }
    
    // IBActions
    @IBAction func addCityButtonTapped() {
        if let searchedCity = citySearchTextField.text {
            viewModel.addWeather(for: searchedCity) { weatherViewModel in
                self.delegate?.addWeatherDidSave(weatherViewModel)
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemperature: UILabel!
    
    func configure(with viewModel: WeatherViewModel, selectedUnit: String) {
        cityName.text = viewModel.cityName
        cityTemperature.text = String(viewModel.cityTemperature.formatAsDegree()) + ""  + "°" + selectedUnit
        self.selectionStyle = .none
    }
}

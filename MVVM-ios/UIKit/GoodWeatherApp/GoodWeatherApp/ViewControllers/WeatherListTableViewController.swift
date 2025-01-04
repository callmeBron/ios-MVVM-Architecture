import UIKit

class WeatherListTableViewController: UITableViewController {
    let viewModel = WeatherListViewModel()
    private var lastUnitSelection: WeatherUnit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        if let userSavedUnit = UserDefaults.standard.value(forKey: "unit") as? String {
            self.lastUnitSelection = WeatherUnit(rawValue: userSavedUnit)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCityViewController" {
            preparSegueForAddCityViewController(with: segue)
        }else if segue.identifier == "SettingsTableViewController" {
            preparSegueForSettingsTableViewController(with: segue)
        }
    }
    
    func preparSegueForAddCityViewController(with segue: UIStoryboardSegue) {
        guard let navigationController = segue.destination as? UINavigationController else { fatalError("Nav Controller not found") }
        guard let addCityViewController = navigationController.viewControllers.first as? AddCityViewController else { fatalError("AddCityViewController not found") }
        
        addCityViewController.delegate = self
    }
    
    func preparSegueForSettingsTableViewController(with segue: UIStoryboardSegue) {
        guard let navigationController = segue.destination as? UINavigationController else { fatalError("Nav Controller not found") }
        guard let settingsTableViewController = navigationController.viewControllers.first as? SettingsTableViewController else { fatalError("SettingsTableViewController not found") }
        
        settingsTableViewController.settingsDelegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
                                                      for: indexPath) as? WeatherCell else { fatalError(" we could not create the cell") }
        let city = viewModel.cityModel(at: indexPath.row)
        cell.configure(with: city, selectedUnit: lastUnitSelection.abbreviation)
        return cell
    }
    
   
}

extension WeatherListTableViewController: AddWeatherDelegate  {
    // MARK: AddWeather Delegate function
    func addWeatherDidSave(_ weatherViewModel: WeatherViewModel) {
        viewModel.addWeatherViewModel(weatherViewModel)
        self.tableView.reloadData()
    }
}


extension WeatherListTableViewController: SettingsDidChangeDelegate  {
    // MARK: Settings Delegate function
    func settingsDone(viewModel: SettingsViewModel) {
        if lastUnitSelection.rawValue != viewModel.selectedUnit.rawValue {
            self.viewModel.updateUnit(with: viewModel.selectedUnit)
            tableView.reloadData()
            lastUnitSelection = WeatherUnit(rawValue: viewModel.selectedUnit.rawValue)
        }
    }
    
    
}

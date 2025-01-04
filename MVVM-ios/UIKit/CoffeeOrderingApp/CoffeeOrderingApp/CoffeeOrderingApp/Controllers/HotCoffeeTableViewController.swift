import UIKit

class HotCoffeeTableViewController: UITableViewController, AddCoffeOrderDelegate {
    let webService: WebService = ConcreteWebService()
    var listViewModel = HotCoffeListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.listViewModel.orderViewModel(at: indexPath.row)
        let cell  = tableView.dequeueReusableCell(withIdentifier: "CoffeTableViewCell",
                                                  for: indexPath)
        cell.textLabel?.text = viewModel.type
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        
        cell.selectionStyle = .none
        
        cell.detailTextLabel?.text = viewModel.size
        cell.detailTextLabel?.textColor = .systemGray
        cell.detailTextLabel?.font = .italicSystemFont(ofSize: 13)
        
        return cell
    }
    
    private func populateOrders() {
        webService.load(resource: OrderModel.all) { [weak self] response in
            switch response {
            case .success(let orders):
                self?.listViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController,
              let orderViewController = navigationController.viewControllers.first as? OrdersViewController else { fatalError("Error with Segue") }
        orderViewController.viewDelegate = self
    }
    
    // delegate functions
    func addCoffeeViewControllerDidSave(order: OrderModel, controller: UIViewController) {
        controller.dismiss(animated: true)
        let orderViewModel = OrderViewModel(order: order)
        self.listViewModel.ordersViewModel.append(orderViewModel)
        self.tableView.insertRows(at: [IndexPath.init(row: self.listViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
    }
    
    func addCoffeeViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true)
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}

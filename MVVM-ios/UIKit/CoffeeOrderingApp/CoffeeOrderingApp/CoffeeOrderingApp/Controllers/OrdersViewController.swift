import UIKit

protocol AddCoffeOrderDelegate {
    func addCoffeeViewControllerDidSave(order: OrderModel, controller: UIViewController )
    func addCoffeeViewControllerDidClose(controller: UIViewController )
}

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var addOrderTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var viewModel = AddCoffeeOrderViewModel()
    private var coffeSizeSegmentControl: UISegmentedControl!
    
    var viewDelegate: AddCoffeOrderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    private func setupScreen() {
        self.coffeSizeSegmentControl = UISegmentedControl(items: self.viewModel.sizes)
        self.coffeSizeSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeSizeSegmentControl)
        self.coffeSizeSegmentControl.topAnchor.constraint(equalTo: self.addOrderTableView.bottomAnchor,
                                                          constant: 5).isActive = true
        self.coffeSizeSegmentControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.nameTextField.placeholder = "John Doe"
        self.emailTextField.placeholder = "JohnDeez@mail.com"
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeCell", for: indexPath)
        cell.textLabel?.text = viewModel.types[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    // IBAction functions
    @IBAction func saveButtonTapped() {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        let selectedSize = self.coffeSizeSegmentControl.titleForSegment(at: self.coffeSizeSegmentControl.selectedSegmentIndex)
        guard let indexPath = self.addOrderTableView.indexPathForSelectedRow else { fatalError("Error in selecting Coffee") }
            
        self.viewModel.name = name
        self.viewModel.email = email
        self.viewModel.selectedSize = selectedSize
        self.viewModel.selectedType = self.viewModel.types[indexPath.row]
        
        ConcreteWebService().load(resource: OrderModel.createOrder(from: viewModel)) { result in
            switch result {
            case .success(let order):
                if let successfulOrder = order, let delegate = self.viewDelegate {
                    DispatchQueue.main.async {
                        delegate.addCoffeeViewControllerDidSave(order: successfulOrder,
                                                                controller: self)
                    }
                }
               
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func closeButtonTapped() {
        if let viewDelegate {
            viewDelegate.addCoffeeViewControllerDidClose(controller: self)
        }
    }
}

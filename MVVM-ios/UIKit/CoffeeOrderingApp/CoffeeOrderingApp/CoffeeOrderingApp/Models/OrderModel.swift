import Foundation

enum CoffeeSize: String, Codable,  CaseIterable {
    case small
    case medium
    case large
}

enum CoffeType: String, Codable, CaseIterable {
    case latte
    case cappuccino
    case cortado
    case mocha
    case espresso
}

struct OrderModel: Codable {
    let name: String
    let email: String
    let type: CoffeType
    let size: CoffeeSize
}

extension OrderModel {
    static var all: Resource<[OrderModel]>  = {
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else { fatalError("Incorrect URL") }
        return Resource<[OrderModel]>(url: url)
    }()
    
    static func createOrder(from viewModel: AddCoffeeOrderViewModel) -> Resource<OrderModel?> {
        let order = OrderModel(viewModel)
        
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else { fatalError("Incorrect URL") }
        guard let data = try? JSONEncoder().encode(order) else { fatalError("Error encoding order") }
        
        var resource = Resource<OrderModel?>(url: url)
        resource.methodType = .post
        resource.body = data
        
        return resource
    }
}

extension OrderModel {
    init?(_ viewModel: AddCoffeeOrderViewModel) {
        guard let name = viewModel.name,
              let email = viewModel.email,
              let type = CoffeType(rawValue: viewModel.selectedType!.lowercased()),
              let size = CoffeeSize(rawValue: viewModel.selectedSize!.lowercased()) else { return nil }
        
        self.name = name
        self.email = email
        self.type = type
        self.size = size
    }
}

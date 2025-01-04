import Foundation

enum NetworkErrorState:Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

struct Resource<T: Codable> {
    let url: URL
    var methodType: HttpMethod = .get
    var body: Data? = nil
    
    init(url: URL) {
        self.url = url
    }
}

protocol WebService {
    func load<T>(resource: Resource<T>, completion: @escaping(Result<T, NetworkErrorState>) -> Void)
}

class ConcreteWebService: WebService {
    func load<T>(resource: Resource<T>, completion: @escaping(Result<T, NetworkErrorState>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.methodType.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { completion(.failure(.domainError)); return }
            let result = try? JSONDecoder().decode(T.self, from: data)
            
            guard let result else { completion(.failure(.decodingError)); return }
            
            DispatchQueue.main.async { completion(.success(result)) }
        }.resume()
    }
    
   
}

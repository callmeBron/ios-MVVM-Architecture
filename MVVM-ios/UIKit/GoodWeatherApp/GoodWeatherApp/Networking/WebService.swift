import Foundation

final class WebService {    
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { data, response , error in
            if let data = data {
                // we are calling this on the main thread because in this example we will be directly calling this 'load' function on the view controller, which runs on the main thread.
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }
        .resume()
    }
}

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T
}

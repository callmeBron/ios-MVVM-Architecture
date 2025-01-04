import Foundation

protocol NewsService {
    func getArticles(from url: URL, completion: @escaping ([Article]?) ->())
}
class WebService: NewsService {
    
    func getArticles(from url: URL, completion: @escaping ([Article]?) ->()) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { articleData, metaData, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let articleData = articleData {
                let newsList = try? JSONDecoder().decode(NewsModel.self, from: articleData)
                if let newsList = newsList {
                    completion(newsList.articles)
                }
            }
        }.resume()
    }
}

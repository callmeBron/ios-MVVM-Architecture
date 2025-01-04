import Foundation

// logic is done within the models
// viewModels are just passing the data to the view

struct NewsModel: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
    let author: String
}

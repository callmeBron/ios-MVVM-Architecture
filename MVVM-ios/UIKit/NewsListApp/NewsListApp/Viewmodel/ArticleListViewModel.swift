import Foundation

// a parent view model will help you when representing your screen
struct ArticleListViewModel {
    let articles: [Article]
    
}

extension ArticleListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(for sectionCount: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}

// will provide some user data to an interface
struct ArticleViewModel {
    private let article: Article
    
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: String {
        return article.title
    }
    
    var description: String {
        return article.description
    }
    
    var author: String {
        return "written by \(article.author)"
    }
}

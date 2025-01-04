import Foundation
import UIKit

class NewsListTableViewController: UITableViewController {
    private var articleListViewModel: ArticleListViewModel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchArticles()
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
         setupView()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return  self.articleListViewModel == nil ? 0 : self.articleListViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListViewModel.numberOfRows(for: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else { fatalError("ArticleTableViewCell not found") }
        let vm = self.articleListViewModel.articleAtIndex(indexPath.row)
        cell.title.text = vm.title
        cell.title.font = .boldSystemFont(ofSize: 17)
        cell.descriptionText.text = vm.description
        cell.author.text = vm.author
        return cell
    }
    
    private func fetchArticles() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6fa3178d5f8e4f70835932d87d055693") else { return }
        WebService().getArticles(from: url) { articles in
            if let articles = articles {
                self.articleListViewModel = ArticleListViewModel(articles: articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

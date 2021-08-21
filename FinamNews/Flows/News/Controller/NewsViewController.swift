//
//  NewsViewController.swift
//  FinamNews
//
//  Created by Илья Кадыров on 19.08.2021.
//

import UIKit

class NewsViewController: UITableViewController {
    
    private let presenter: NewsViewToPresenter
    
    let cellId = "NewsCell"
    
    let newsService = NewsService()
    let dateService = DateService()
    let alertFactory = AlertFactory()
    var news = [News]()

    init(presenter: NewsViewToPresenter) {
        self.presenter = presenter
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
        self.setupRefreshControl()
        self.presenter.startLoadNews()

    }
    
    fileprivate func setupRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        self.refreshControl?.tintColor = .gray
        self.refreshControl?.addTarget(self, action: #selector(startUpdateExist), for: .valueChanged)
       }
    
    @objc func startUpdateExist() {
        
        self.refreshControl?.beginRefreshing()
        guard self.news.count > 0,
              let to = self.news.first?.publishedAt,
              let from = self.news.last?.publishedAt else {
            self.presenter.startLoadNews()
            return
        }
        let pageSizeOldElem = String(self.news.count)
        self.presenter.startUpdateExist(updateFrom: from, updateTo: to, pageSize: pageSizeOldElem)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: self.cellId)
        let currentNews = self.news[indexPath.row]
        cell.textLabel?.text = currentNews.title
        cell.detailTextLabel?.text = currentNews.newsDescription

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = self.news[indexPath.row]
        self.navigationController?.pushViewController(CurrentNewsController(news: selectedNews), animated: true)
    }

}

extension NewsViewController: NewsPresenterToView {
    func loadNewNews(newNews: [News]) {
        
        self.refreshControl?.endRefreshing()
        self.news = newNews + self.news
        self.tableView.reloadData()
    }
    
    
    func updateExistAndStartLoadNewNews(news: [News]) {
        self.news = news
        guard let newestPublishDate = self.news.first?.publishedAt else {
            return
        }
        self.presenter.startLoadNewNews(newestPublishDate: newestPublishDate)
    }
    
    func showMessage(text: String, messageType: MessageTypeEnum) {
        let message: UIAlertController
        switch messageType {
        case .message:
            message = alertFactory.makeMessageAlert(text: text)
        case .error:
            message = alertFactory.makeErrorAlert(text: text)
        }
        self.present(message, animated: true, completion: nil)
    }
    
    
    func loadNews(news: [News]) {
        self.news = news
        self.tableView.reloadData()
    }
    
    
}

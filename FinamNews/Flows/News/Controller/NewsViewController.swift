//
//  NewsViewController.swift
//  FinamNews
//
//  Created by Илья Кадыров on 19.08.2021.
//

import UIKit

class NewsViewController: UITableViewController {
    
    let cellId = "NewsCell"
    
    let newsService = NewsService()
    let dateService = DateService()
    var news = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
        self.setupRefreshControl()
        self.loadNews()

    }
    
    fileprivate func setupRefreshControl() {
           
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        self.refreshControl?.tintColor = .gray
        self.refreshControl?.addTarget(self, action: #selector(updateExistAndLoadNewNews), for: .valueChanged)
       }
    
    func loadNews() {
        newsService.getNews(from: nil, to: dateService.getYesterday(), pageSize: nil) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                self.news = result.articles ?? []
                self.tableView.reloadData()
            case .failure(let error):
             print(error)
            }
         }
    }
    
    func loadNewNews() {
        let nowDate = Date()
        let nowDateStr = dateService.getIsoStringFromDate(date: nowDate)//dateFormatter.string(from: nowDate)
        let newestPublishDate = self.news.first?.publishedAt ?? nowDateStr
        let dateFrom: String
        if let date = dateService.getDateFromIsoString(string: newestPublishDate) {
            let calendar = Calendar.current
            let increaseDate = calendar.date(byAdding: .second, value: 1, to: date) ?? Date()
            dateFrom = dateService.getIsoStringFromDate(date: increaseDate)
        } else {
            dateFrom = dateService.getIsoStringFromDate(date: nowDate)
        }
        
        newsService.getNews(from: dateFrom, to: nil, pageSize: nil) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                self.refreshControl?.endRefreshing()
                
                guard let newNews = result.articles, newNews.count > 0 else { return }
                
                self.news = newNews + self.news
                self.tableView.reloadData()
                
            case .failure(let error):
             print(error)
            }
         }
        
    }
    
    @objc func updateExistAndLoadNewNews() {
        self.refreshControl?.beginRefreshing()
        
        guard self.news.count > 0,
              let to = self.news.first?.publishedAt,
              let from = self.news.last?.publishedAt else {
            loadNews()
            return
        }
        let pageSizeOldElem = String(self.news.count)
        newsService.getNews(from: from, to: to, pageSize: pageSizeOldElem) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                if let articles = result.articles {
                    self.news = articles
                    self.loadNewNews()
                }
                
            case .failure(let error):
             print(error)
            }
    }
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



}


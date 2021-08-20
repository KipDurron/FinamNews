//
//  NewsPresenter.swift
//  FinamNews
//
//  Created by Илья Кадыров on 20.08.2021.
//

import Foundation

class NewsPresenter {
    private weak var controller: NewsPresenterToView?
    
    let newsService = NewsService()
    let dateService = DateService()
    
    func setController(controller: NewsPresenterToView) {
        self.controller = controller
    }
}

extension NewsPresenter: NewsViewToPresenter {
    
    func startLoadNewNews(newestPublishDate: String) {
        let nowDate = Date()
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
                guard result.status != APISetting.codeError.rawValue else {
                    self.controller?.showMessage(text: "\(result.message ?? "error")", messageType: .error)
                    return
                }
                if let articles = result.articles {
                    self.controller?.loadNewNews(newNews: articles)
                }
                
            case .failure(let error):
                self.controller?.showMessage(text: "\(error)", messageType: .error)
            }
         }
    }
    
    func startUpdateExist(updateFrom: String, updateTo: String, pageSize: String) {
        
        newsService.getNews(from: updateFrom, to: updateTo, pageSize: pageSize) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                guard result.status != APISetting.codeError.rawValue else {
                    self.controller?.showMessage(text: "\(result.message ?? "error")", messageType: .error)
                    return
                }
                if let articles = result.articles {
                    self.controller?.updateExistAndStartLoadNewNews(news: articles)

                }
                
            case .failure(let error):
                self.controller?.showMessage(text: "\(error)", messageType: .error)
            }
    }
    }
    
    
    func startLoadNews() {
        newsService.getNews(from: nil, to: dateService.getYesterday(), pageSize: nil) { [weak self] (response) in
            guard let self = self else { return }
            guard let controller = self.controller else { return }
            switch response.result {
            case .success(let result):
                guard result.status != APISetting.codeError.rawValue else {
                    self.controller?.showMessage(text: "\(result.message ?? "error")", messageType: .error)
                    return
                }
                controller.loadNews(news: result.articles ?? [])
            case .failure(let error):
                self.controller?.showMessage(text: "\(error)", messageType: .error)
            }
         }
    }
    

}

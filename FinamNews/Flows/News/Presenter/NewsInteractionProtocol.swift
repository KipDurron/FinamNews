//
//  NewsInteractionProtocol.swift
//  FinamNews
//
//  Created by Илья Кадыров on 20.08.2021.
//

import Foundation

protocol NewsViewToPresenter: AnyObject {
    func startLoadNews()
    func startUpdateExist(updateFrom: String, updateTo: String, pageSize: String)
    func startLoadNewNews(newestPublishDate: String)
}

protocol NewsPresenterToView: AnyObject {
    func loadNews(news: [News])
    func updateExistAndStartLoadNewNews(news: [News])
    func loadNewNews(newNews: [News])
    func showMessage(text: String, messageType: MessageTypeEnum)
}

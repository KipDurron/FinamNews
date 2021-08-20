//
//  NewsService.swift
//  FinamNews
//
//  Created by Илья Кадыров on 19.08.2021.
//

import Foundation
import Alamofire

class NewsService {

    func getNews(completion: @escaping (AFDataResponse<GetNewsResponse>) -> Void) {
        
        let urlRequest = APISetting.getAppleNews.rawValue // + "&to=" + isoDateNow
        AF.request(urlRequest).responseDecodable(completionHandler: completion)
        
    }
    
    func getNews(from: String?,
                 to: String?,
                 pageSize: String?,
                 completion: @escaping (AFDataResponse<GetNewsResponse>) -> Void) {
        var urlRequest = APISetting.getAppleNews.rawValue
        if let from = from {
            urlRequest += APISetting.from.rawValue + from
        }
        if let to = to {
            urlRequest += APISetting.to.rawValue + to
        }
        if let pageSize = pageSize {
            urlRequest += APISetting.pageSize.rawValue + pageSize
        } else {
            urlRequest += APISetting.pageSize.rawValue + APISetting.basePageSize.rawValue
        }
        AF.request(urlRequest).responseDecodable(completionHandler: completion)
        
    }
}

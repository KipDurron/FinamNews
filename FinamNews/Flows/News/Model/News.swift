//
//  News.swift
//  FinamNews
//
//  Created by Илья Кадыров on 19.08.2021.
//


struct News: Codable {
    
    var title: String?
    var author: String?
    var publishedAt: String?
    var urlToImage: String?
    var newsDescription: String?
    var url: String?
    
    private enum CodingKeys: String, CodingKey {
        case newsDescription = "description"
        case title = "title"
        case author = "author"
        case publishedAt = "publishedAt"
        case urlToImage = "urlToImage"
        case url = "url"
    }
}

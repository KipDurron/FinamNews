//
//  GetAllNewsResponse.swift
//  FinamNews
//
//  Created by Илья Кадыров on 19.08.2021.
//

import Foundation

struct GetNewsResponse: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [News]?
    var code: String?
    var message: String?
}

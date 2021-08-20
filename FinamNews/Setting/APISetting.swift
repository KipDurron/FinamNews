//
//  APISetting.swift
//  FinamNews
//
//  Created by Илья Кадыров on 19.08.2021.
//

import Foundation

enum APISetting: String {
    case apiKey = "98e8910adc1c4527a9dc5d2e4d88fc43"
    case getAppleNews =
            "https://newsapi.org/v2/everything?sortBy=publishedAt&apiKey=98e8910adc1c4527a9dc5d2e4d88fc43&q=apple"
    case basePageSize = "3"
    case pageSize = "&pageSize="
    case to = "&to="
    case from = "&from="
    case codeError = "error"
}

//
//  DateService.swift
//  FinamNews
//
//  Created by Илья Кадыров on 20.08.2021.
//

import Foundation
class DateService {
    let dateIsoFormatter = ISO8601DateFormatter()
    
    func getYesterday() -> String {
        let calendar = Calendar.current
        let yesterdayDate = calendar.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        return dateIsoFormatter.string(from: yesterdayDate)
    }
    
    func getIsoStringFromDate(date: Date) -> String{
        return dateIsoFormatter.string(from: date)
    }
    func getDateFromIsoString(string: String) -> Date? {
        return dateIsoFormatter.date(from:string)
    }
    
}

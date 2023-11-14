//
//  DateHelper.swift
//  Atty
//
//  Created by Nikita Melnikov on 13.11.2023.
//

import Foundation

class DateHelper {
    
    static let dateFormatter = DateFormatter()
    
    static func compareDates(date: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        let currentDate = calendar.dateComponents([.day, .month, .year], from: Date())
        
        return components.day == currentDate.day && components.month == currentDate.month && components.year == currentDate.year
    }
    
    static func formatDate(_ date: Date) -> String {
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "uk_UA")
        return dateFormatter.string(from: date)
    }
    
    static func formateDateFromApi(date: String) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: date)
        return date
    }
}


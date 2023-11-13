//
//  DateHelper.swift
//  Atty
//
//  Created by Nikita Melnikov on 13.11.2023.
//

import Foundation

class DateHelper {
    
    static func compareDates(date: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        let currentDate = calendar.dateComponents([.day, .month, .year], from: Date())
        
        return components.day == currentDate.day && components.month == currentDate.month && components.year == currentDate.year
    }
    
    static func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "uk_UA")
        return dateFormatter.string(from: date)
    }
}


//
//  Date+TimeAgo.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import Foundation

enum DateFormat: String {
    case baseFormat = "yyyy-MM-dd'T'HH:mm:ssZ"  // 2008-01-12T05:38:33Z
    case lessThanSixMonths = "EEEE, MMM d, yyyy"  // Saturday, Sep 11, 2021
}

extension Date {
    
    func timeAgo() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: Date())
        if let year = interval.year, year > 0, let month = interval.month, month > 0  {
            return year == 1 ? "\(month)" + " month ago, " + "\(year)" + " years ago" : "\(month)" + " month ago, " + "\(year)" + " years ago"
        } else if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else {
            return "-"
        }
    }
    
    func toString(withFormat format: DateFormat = .lessThanSixMonths) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let str = dateFormatter.string(from: self)
        return str
    }
    
}

extension String {
    func toDate(withFormat format: String = DateFormat.baseFormat.rawValue) -> Date? {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        dateFormatter.locale = tempLocale
        let date = dateFormatter.date(from: self)
        return date
    }
        
    func monthsBetween() -> Int {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return Calendar.current.dateComponents([.month], from: self.toDate() ?? Date(), to: currentDateTime).month!
    }
}

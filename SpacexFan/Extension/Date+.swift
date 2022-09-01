//
//  Date+.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//

import Foundation

// MARK: Dateformatter - > fullISO8601
extension DateFormatter {

    static let fullISO8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

// MARK: Date - > convertToMonthDayYearTimeFormat
extension Date {

    func convertToMonthDayYearTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy - h:mm a"
        return dateFormatter.string(from: self)
    }
}

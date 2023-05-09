//
//  TEDateFormatter.swift
//  TinkoffExpress
//
//  Created by r.akhmadeev on 09.05.2023.
//

import Foundation

protocol ITEDateFormatter {
    func format(date: Date) -> String
    func format(date: Date, timeFrom: String, timeTo: String) -> String
    func format(date: String, timeFrom: String, timeTo: String) -> String
}

final class TEDateFormatter: ITEDateFormatter {
    private lazy var localizedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate("d-MMMM")
        return formatter
    }()

    private lazy var apiFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private let calendar = Calendar.current

    func format(date: Date) -> String {
        if calendar.isDateInToday(date) {
            return "Сегодня"
        } else if calendar.isDateInTomorrow(date) {
            return "Завтра"
        } else {
            return localizedFormatter.string(from: date)
        }
    }

    func format(date: Date, timeFrom: String, timeTo: String) -> String {
        "\(format(date: date)) с \(timeFrom) по \(timeTo)"
    }

    func format(date: String, timeFrom: String, timeTo: String) -> String {
        let date = apiFormatter.date(from: date) ?? Date()
        return format(date: date, timeFrom: timeFrom, timeTo: timeTo)
    }
}

//
//  TimeSlot.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

import Foundation

struct TimeSlot: Codable {
    let date: String
    let timeFrom: String
    let timeTo: String
    
    private enum CodingKeys: String, CodingKey {
        case date
        case timeFrom = "time_from"
        case timeTo = "time_to"
    }
}

//
//  TEApiPaymentMethod.swift
//  TinkoffExpress
//
//  Created by r.akhmadeev on 09.05.2023.
//

import Foundation

enum TEApiPaymentMethod: String, Codable {
    case card = "CARD"
    case cash = "CASH"

    var localized: String {
        switch self {
        case .card:
            return "Картой при получении"
        case .cash:
            return "Наличными курьеру"
        }
    }
}

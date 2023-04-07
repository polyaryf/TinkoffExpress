//
//  PaymentMethod.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

enum PaymentMethodType: String, Codable {
    case CARD
    case CASH
}

struct PaymentMethod: Codable {
    let type: PaymentMethodType
}

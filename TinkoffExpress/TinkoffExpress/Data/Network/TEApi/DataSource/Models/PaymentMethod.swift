//
//  PaymentMethod.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

enum PaymentMethodType: String {
    case CARD
    case CASH
}

struct PaymentMethod {
    let type: PaymentMethodType.RawValue
}

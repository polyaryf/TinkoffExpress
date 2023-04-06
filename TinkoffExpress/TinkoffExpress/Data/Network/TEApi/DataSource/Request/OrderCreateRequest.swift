//
//  OrderCreateRequest.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

import Foundation

struct OrderCreateRequest {
    let address: Address
    let paymentMethod: PaymentMethod
    let deliverySlot: TimeSlot
    let items: [Item]
    let comment: String
    let status: String?
}

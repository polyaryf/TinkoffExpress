//
//  TEApiOrder.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

import Foundation

struct TEApiOrder: Codable {
    let address: TEApiAddress
    let paymentMethod: TEApiPaymentMethod
    let deliverySlot: TEApiTimeSlot
    let items: [TEApiItem]
    let comment: String
    let status: TEApiOrderStatus
    let id: Int
    
    private enum CodingKeys: String, CodingKey {
        case address = "point"
        case paymentMethod = "payment_method"
        case deliverySlot = "delivery_slot"
        case items
        case comment
        case status
        case id
    }
}

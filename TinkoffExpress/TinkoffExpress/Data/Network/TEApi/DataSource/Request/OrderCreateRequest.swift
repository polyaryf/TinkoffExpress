//
//  OrderCreateRequest.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

import Foundation

struct OrderCreateRequest: Codable {
    let address: TEApiAddress
    let paymentMethod: String
    let deliverySlot: TEApiTimeSlot
    let items: [TEApiItem]
    let comment: String
    let status: TEApiOrderStatus?
    
    private enum CodingKeys: String, CodingKey {
        case address = "point"
        case paymentMethod = "payment_method"
        case deliverySlot = "delivery_slot"
        case items
        case comment
        case status
    }
}

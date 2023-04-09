//
//  OrderCreateRequest.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

import Foundation

struct OrderCreateRequest: Codable {
    let address: Address
    let paymentMethod: String
    let deliverySlot: TimeSlot
    let items: [Item]
    let comment: String
    let status: String?
    
    private enum CodingKeys: String, CodingKey {
        case address = "point"
        case paymentMethod = "payment_method"
        case deliverySlot = "delivery_slot"
        case items
        case comment
        case status
    }
}

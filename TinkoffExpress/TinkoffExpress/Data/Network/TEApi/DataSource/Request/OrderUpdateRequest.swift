//
//  OrderUpdateRequest.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

struct OrderUpdateRequest: Codable {
    let address: TEApiAddress?
    let paymentMethod: String?
    let deliverySlot: TEApiTimeSlot?
    let comment: String?
    let status: TEApiOrderStatus?
    
    private enum CodingKeys: String, CodingKey {
        case address = "point"
        case paymentMethod = "payment_method"
        case deliverySlot = "delivery_slot"
        case comment
        case status
    }
}

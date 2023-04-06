//
//  OrderUpdateRequest.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

struct OrderUpdateRequest {
    let address: Address?
    let paymentMethod: PaymentMethod?
    let deliverySlot: TimeSlot?
    let comment: String?
    let status: String?
}


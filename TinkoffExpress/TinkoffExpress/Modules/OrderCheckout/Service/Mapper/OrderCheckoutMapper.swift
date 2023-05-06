//
//  OrderCheckoutMapper.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 05.05.2023.
//

import Foundation

protocol IOrderCheckoutMapper {
    func toOrderCheckout(from model: MyOrder) -> OrderCheckout
    func toOrderCreateRequest() -> OrderCreateRequest
}

final class OrderCheckoutMapper: IOrderCheckoutMapper {
    // MARK: IOrderCheckoutMapper
    
    func toOrderCheckout(from model: MyOrder) -> OrderCheckout {
        OrderCheckout(
            whatWillBeDelivered: "",
            deliveryWhen: "",
            deliveryWhere: "",
            paymentMethod: ""
        )
    }
    
    func toOrderCreateRequest() -> OrderCreateRequest {
        OrderCreateRequest(
            address: TEApiAddress(address: "", lat: 0, lon: 0),
            paymentMethod: "CARD",
            deliverySlot: TEApiTimeSlot(date: "", timeFrom: "", timeTo: ""),
            items: [],
            comment: "",
            status: ""
        )
    }
}

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
    func toFinalDelivery(from model: OrderCheckout) -> FinalDelivery
    func toTEApiItems(from products: [CartProduct]) -> [TEApiItem]
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
            status: .created
        )
    }
    
    func toFinalDelivery(from model: OrderCheckout) -> FinalDelivery {
        FinalDelivery(
            where: model.deliveryWhere,
            when: model.deliveryWhen,
            what: "Посылку"
        )
    }
    
    func toTEApiItems(from products: [CartProduct]) -> [TEApiItem] {
        var items: [TEApiItem] = []
        for cartProduct in products {
            for _ in 0 ..< cartProduct.counter {
                items.append(TEApiItem(
                    name: cartProduct.product.title,
                    price: cartProduct.product.price)
                )
            }
        }
        
        return items
    }
}

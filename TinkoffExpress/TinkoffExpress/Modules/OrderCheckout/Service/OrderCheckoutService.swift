//
//  OrderCheckoutService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import Foundation

protocol OrderCheckoutService {
    func loadItems(completion: @escaping ([OrderCheckout]?) -> Void)
}

class MockOrderCheckoutService: OrderCheckoutService {
    func loadItems(completion: @escaping ([OrderCheckout]?) -> Void) {
        let items: [OrderCheckout] = [
            .init(
                whatWillBeDelivered: "Посылку",
                deliveryWhen: "Завтра с 10:00 до 12:00",
                deliveryWhere: "Ивангород, ул. Гагарина, д. 1",
                paymentMethod: "Картой при получении")
        ]
        completion(items)
    }
}

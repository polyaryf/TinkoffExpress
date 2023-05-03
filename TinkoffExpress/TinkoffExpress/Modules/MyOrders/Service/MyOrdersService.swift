//
//  MyOrdersService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import Foundation

protocol MyOrdersService {
    func loadItems(completion: @escaping ([MyOrders]?) -> Void)
}

final class MockMyOrdersService: MyOrdersService {
    func loadItems(completion: @escaping ([MyOrders]?) -> Void) {
        let items: [MyOrders] = [
            .init(text: "Доставка", description: "Завтра, с 10:00 до 12:00", imageName: "myOrdersDeliveryImage"),
            .init(text: "Доставка", description: "Завтра, с 10:00 до 12:00", imageName: "myOrdersDeliveryImage")
        ]
        completion(items)
    }
}

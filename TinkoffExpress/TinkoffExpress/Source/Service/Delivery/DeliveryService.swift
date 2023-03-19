//
//  DeliveryService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 19.03.2023.
//

import Foundation

protocol DeliveryService {
    func loadItems(completion: @escaping ([Delivery]?) -> Void)
}

class MockDeliveryService: DeliveryService {
    func loadItems(completion: @escaping ([Delivery]?) -> Void) {
        let items: [Delivery] = [
            .init(text: "Доставка", imageName: "deliveryLetter"),
            .init(text: "Самовывоз", imageName: "deliveryPin")
        ]
        completion(items)
    }
}

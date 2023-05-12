//
//  DeliveryService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import Foundation

protocol DeliveryService {
    func loadItems(completion: @escaping ([Delivery]?) -> Void)
}

final class MockDeliveryService: DeliveryService {
    func loadItems(completion: @escaping ([Delivery]?) -> Void) {
        let items: [Delivery] = [
            .init(text: NSLocalizedString("deliveryLetter", comment: ""), imageName: "deliveryLetter")
        ]
        completion(items)
    }
}

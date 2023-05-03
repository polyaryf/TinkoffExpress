//
//  FinalDeliveryService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import Foundation

protocol FinalDeliveryService {
    func loadItem(completion: @escaping (FinalDelivery?) -> Void)
}

class MockFinalDeliveryService: FinalDeliveryService {
    func loadItem(completion: @escaping (FinalDelivery?) -> Void) {
        let item: FinalDelivery = .init(
            where: "Ивангород, ул. Гагарина, д. 1",
            when: "Завтра с 10:00 до 12:00",
            what: "Посылку")
        completion(item)
    }
}

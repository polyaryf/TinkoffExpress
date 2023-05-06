//
//  SettingsService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 06.05.2023.
//

import Foundation

protocol SettingsService {
    func loadItems(completion: @escaping ([Settings]?) -> Void)
}

final class MockSettingsService: SettingsService {
    func loadItems(completion: @escaping ([Settings]?) -> Void) {
        let items: [Settings] = [
            .init(
                text: "Поиск",
                description: "Стандартный",
                imageName: "myOrdersDeliveryImage",
                isActive: true
            ),
            .init(
                text: "Локализация",
                description: "Русская",
                imageName: "myOrdersDeliveryImage",
                isActive: true
            )
        ]
        completion(items)
    }
}

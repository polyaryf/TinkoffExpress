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
                text: NSLocalizedString("settingsSearchTitle", comment: ""),
                description: NSLocalizedString("settingsSearchStandart", comment: ""),
                imageName: "myOrdersDeliveryImage",
                isActive: true
            )
        ]
        completion(items)
    }
}

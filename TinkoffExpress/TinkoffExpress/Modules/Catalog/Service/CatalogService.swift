//
//  CatalogService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.05.2023.
//

import Foundation

protocol CatalogService {
    func loadItems(completion: @escaping ([Product]) -> Void)
}

final class MockCatalogService: CatalogService {
    func loadItems(completion: @escaping ([Product]) -> Void) {
        let products: [Product] = [
            .init(title: "Чайник электрический", price: "3 556 ₽", image: "kettle"),
            .init(title: "Чайник электрический", price: "3 556 ₽", image: "kettle"),
            .init(title: "Чайник электрический", price: "3 556 ₽", image: "kettle")
        ]
        completion(products)
    }
}

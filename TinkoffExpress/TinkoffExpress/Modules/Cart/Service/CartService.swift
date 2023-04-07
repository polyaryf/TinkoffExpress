//
//  CartService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import Foundation
import Combine

protocol CartService {
    func loadItems(completion: @escaping ([Cart]?) -> Void)
}

final class RestCartService: CartService {
    private var cancellables = Set<AnyCancellable>()
    
    func loadItems(completion: @escaping ([Cart]?) -> Void) {
        let network = TEApiService()
        network
            .getOrders()
            .sink { complitionn in
                print(complitionn.hashValue)
            }
            receiveValue: { orders in
                var carts: [Cart] = []
                for order in orders {
                    for item in order.items {
                        carts.append(Cart(text: item.name, imageName: "kettle"))
                    }
                }
                print(carts)
                completion(carts)
            }
        .store(in: &cancellables)
    }
}

final class MockCartService: CartService {
    func loadItems(completion: @escaping ([Cart]?) -> Void) {
        let items: [Cart] = [
            .init(text: "Чайник электрический Xiaomi Mi Smart Kettle RU EAC White", imageName: "kettle"),
            .init(text: "Чайник 2", imageName: "kettle"),
            .init(text: "Чайник 3", imageName: "kettle"),
            .init(text: "Чайник 4", imageName: "kettle"),
            .init(text: "Чайник 5", imageName: "kettle"),
            .init(text: "Чайник 6", imageName: "kettle"),
            .init(text: "Чайник 7", imageName: "kettle"),
            .init(text: "Чайник 8", imageName: "kettle"),
            .init(text: "Чайник 9", imageName: "kettle"),
            .init(text: "Чайник 10", imageName: "kettle"),
            .init(text: "Чайник 11", imageName: "kettle"),
            .init(text: "Чайник 12", imageName: "kettle"),
            .init(text: "Чайник 13", imageName: "kettle"),
            .init(text: "Чайник 14", imageName: "kettle"),
            .init(text: "Чайник 15", imageName: "kettle")
        ]
        completion(items)
    }
}

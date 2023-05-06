//
//  MyOrdersService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import Foundation

protocol MyOrdersService {
    func loadItems(completion: @escaping ([MyOrder]?) -> Void)
}

final class RestMyOrdersService {
    // MARK: Dependency
    
    private let networkService: TEApiService
    
    // MARK: Init
    
    init(networkService: TEApiService) {
        self.networkService = networkService
    }
    
    func loadItems(completion: @escaping ([MyOrder]?) -> Void) {
        networkService.getOrders { result in
            let newResult = result.map { apiOrders in
                apiOrders.map { apiOrder in
                    MyOrder(
                        id: apiOrder.id,
                        text: "Доставка",
                        description: apiOrder.deliverySlot.date ,
                        imageName: "myOrdersDeliveryImage")
                }
            }
            switch newResult {
            case .success(let orders): completion(orders)
            case .failure: completion([])
            }
        }
    }
}

final class MockMyOrdersService: MyOrdersService {
    func loadItems(completion: @escaping ([MyOrder]?) -> Void) {
        let items: [MyOrder] = [
            .init(id: 1, text: "Доставка", description: "Завтра, с 10:00 до 12:00", imageName: "myOrdersDeliveryImage"),
            .init(id: 2, text: "Доставка", description: "Завтра, с 10:00 до 12:00", imageName: "myOrdersDeliveryImage")
        ]
        completion(items)
    }
}

//
//  MyOrdersService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import Foundation

protocol MyOrdersService {
    func loadItems(completion: @escaping ([MyOrder]) -> Void)
}

final class RestMyOrdersService: MyOrdersService {
    // MARK: Dependency
    
    private let networkService: TEApiService
    
    // MARK: Init
    
    init(networkService: TEApiService) {
        self.networkService = networkService
    }
    
    func loadItems(completion: @escaping ([MyOrder]) -> Void) {
        networkService.getOrders { result in
            let newResult = result.map { apiOrders in
                apiOrders.compactMap { apiOrder in
                    MyOrder(
                        id: apiOrder.id,
                        text: "Доставка",
                        description: "\(apiOrder.deliverySlot.date) с \(apiOrder.deliverySlot.timeFrom) до \(apiOrder.deliverySlot.timeTo)",
                        imageName: "myOrdersDeliveryImage",
                        address: apiOrder.address.address,
                        paymentMethod: apiOrder.paymentMethod
                    )
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
    func loadItems(completion: @escaping ([MyOrder]) -> Void) {
        let items: [MyOrder] = []
        completion(items)
    }
}

//
//  OrderCheckoutService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import Foundation

protocol OrderCheckoutService {
    func createOrder(with request: OrderCreateRequest, completion: @escaping (Result<Bool, Error>) -> Void)
    func loadItems(completion: @escaping ([OrderCheckout]?) -> Void)
}

final class RestOrderCheckoutService: OrderCheckoutService {
    // MARK: Dependency
    
    private let networkService: TEApiService
    
    // MARK: Init
    
    init(networkService: TEApiService) {
        self.networkService = networkService
    }
    
    // MARK: OrderCheckoutService
    
    func createOrder(
        with request: OrderCreateRequest,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        networkService.createOrder(reqest: request) { result in
            let newResult = result.mapError { $0 as Error }
            completion(newResult)
        }
    }
    
    func loadItems(completion: @escaping ([OrderCheckout]?) -> Void) {
        let items: [OrderCheckout] = [
            .init(
                whatWillBeDelivered: "Посылку",
                deliveryWhen: "Завтра с 10:00 до 12:00",
                deliveryWhere: "Ивангород, ул. Гагарина, д. 1",
                paymentMethod: "Картой при получении")
        ]
        completion(items)
    }
}

class MockOrderCheckoutService: OrderCheckoutService {
    func createOrder(with request: OrderCreateRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
    
    func loadItems(completion: @escaping ([OrderCheckout]?) -> Void) {
        let items: [OrderCheckout] = [
            .init(
                whatWillBeDelivered: "Посылку",
                deliveryWhen: "Завтра с 10:00 до 12:00",
                deliveryWhere: "Ивангород, ул. Гагарина, д. 1",
                paymentMethod: "Картой при получении")
        ]
        completion(items)
    }
}

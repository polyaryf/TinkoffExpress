//
//  OrderCheckoutService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import Foundation

protocol OrderCheckoutService {
    func createOrder(
        with request: OrderCreateRequest,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
    
    func updateOrder(
        id: Int,
        with request: OrderUpdateRequest,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
    
    func deleteOrder()
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
    
    func updateOrder(
        id: Int,
        with request: OrderUpdateRequest,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        networkService.updateOrder(request: request, orderId: id) { result in
            let newResult = result.mapError { $0 as Error }
            completion(newResult)
        }
    }
    
    func deleteOrder() {
        // TODO: запрос на сервер для удаления заказа
    }
}

class MockOrderCheckoutService: OrderCheckoutService {
    func updateOrder(id: Int, with request: OrderUpdateRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
    
    func createOrder(with request: OrderCreateRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
    
    func deleteOrder() {}
}

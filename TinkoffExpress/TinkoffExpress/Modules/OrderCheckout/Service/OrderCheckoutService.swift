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
    
    func delete(
        order: TEApiOrder,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
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
    
    func delete(order: TEApiOrder, completion: @escaping (Result<Bool, Error>) -> Void) {
        let request = OrderUpdateRequest(
            address: order.address,
            paymentMethod: order.paymentMethod.rawValue,
            deliverySlot: order.deliverySlot,
            comment: order.comment,
            status: .cancelled
        )
        networkService.updateOrder(request: request, orderId: order.id) { result in
            let newResult = result.mapError { $0 as Error }
            completion(newResult)
        }
    }
}

class MockOrderCheckoutService: OrderCheckoutService {
    func updateOrder(id: Int, with request: OrderUpdateRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
    
    func createOrder(with request: OrderCreateRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
    
    func delete(order: TEApiOrder, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
}

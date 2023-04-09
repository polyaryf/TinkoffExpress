//
//  TEApiService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.04.2023.
//

import Foundation

class TEApiService: GenericService<TEApiTargetType>, TEApiServiceProtocol {
    func test(
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        perform(
            target: .test,
            completion: completion
        )
    }
    
    func getOrders(
        completion: @escaping (Result<[Order], HttpClientError>) -> Void
    ) {
        performAndDecode(
            target: .getOrders,
            completion: completion
        )
    }
    
    func createOrder(
        reqest: OrderCreateRequest,
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        perform(
            target: .createOrder(request: reqest),
            completion: completion
        )
    }
    
    func updateOrder(
        request: OrderUpdateRequest,
        orderId: Int,
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        perform(
            target: .updateOrder(request: request, orderId: orderId),
            completion: completion
        )
    }
    
    func getSlots(
        completion: @escaping (Result<[TimeSlot], HttpClientError>) -> Void
    ) {
        performAndDecode(
            target: .getSlots,
            completion: completion
        )
    }
}

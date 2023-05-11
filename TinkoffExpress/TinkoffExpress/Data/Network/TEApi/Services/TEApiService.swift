//
//  TEApiService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.04.2023.
//

class TEApiService: TEOrderApiProtocol, TESlotApiProtocol {
    private let service = GenericService<TEApiTargetType>()
    
    func test(
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        service.perform(
            target: .test,
            completion: completion
        )
    }
    
    func getOrders(
        completion: @escaping (Result<[TEApiOrder], HttpClientError>) -> Void
    ) {
        service.performAndDecode(
            target: .getOrders,
            completion: completion
        )
    }
    
    func createOrder(
        reqest: OrderCreateRequest,
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        service.perform(
            target: .createOrder(request: reqest),
            completion: completion
        )
    }
    
    func updateOrder(
        request: OrderUpdateRequest,
        orderId: Int,
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        service.perform(
            target: .updateOrder(request: request, orderId: orderId),
            completion: completion
        )
    }
    
    func getSlots(
        forDate date: String,
        completion: @escaping (Result<[TEApiTimeSlot], HttpClientError>) -> Void
    ) {
        service.performAndDecode(
            target: .getSlots(date: date),
            completion: completion
        )
    }
}

//
//  TEApiService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.04.2023.
//

import Combine
import Foundation

class TEApiService: GenericService<TEApiTargetType>, TEApiServiceProtocol {
    func test() -> Future<Bool, HttpClientError> {
        perform(target: .test)
    }
    
    func getOrders() -> Future<[Order], HttpClientError> {
        performAndDecode(target: .getOrders)
    }
    
    func createOrder(reqest: OrderCreateRequest) -> Future<Bool, HttpClientError> {
        perform(target: .createOrder(request: reqest))
    }
    
    func updateOrder(request: OrderUpdateRequest, orderId: Int) -> Future<Bool, HttpClientError> {
        perform(target: .updateOrder(request: request, orderId: orderId))
    }
    
    func getSlots() -> Future<[TimeSlot], HttpClientError> {
        performAndDecode(target: .getSlots)
    }
}

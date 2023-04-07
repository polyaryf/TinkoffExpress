//
//  TEApiService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 06.04.2023.
//

import Combine

protocol TEApiServiceProtocol {
    func test() -> Future<Bool, HttpClientError>
    func getOrders() -> Future<[Order], HttpClientError>
    func createOrder(reqest: OrderCreateRequest) -> Future<Bool, HttpClientError>
    func updateOrder(request: OrderUpdateRequest, orderId: Int) -> Future<Bool, HttpClientError>
    func getSlots() -> Future<[TimeSlot], HttpClientError>
}

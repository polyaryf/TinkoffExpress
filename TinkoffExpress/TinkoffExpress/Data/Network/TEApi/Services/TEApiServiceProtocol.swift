//
//  TEApiService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 06.04.2023.
//

protocol TEApiServiceProtocol {
    func test(
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    )
    func getOrders(
        completion: @escaping (Result<[Order], HttpClientError>) -> Void
    )
    func createOrder(
        reqest: OrderCreateRequest,
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    )
    func updateOrder(
        request: OrderUpdateRequest, orderId: Int,
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    )
    func getSlots(
        completion: @escaping (Result<[TimeSlot], HttpClientError>) -> Void
    )
}

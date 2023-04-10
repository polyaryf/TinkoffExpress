//
//  TEOrderApiProtocol.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.04.2023.
//

protocol TEOrderApiProtocol {
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
}

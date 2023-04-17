//
//  MockTEApiService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.04.2023.
//

import Foundation

class MockTEApiService: TEOrderApiProtocol, TESlotApiProtocol {
    func test(
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(true))
        }
    }
    
    func getOrders(
        completion: @escaping (Result<[TEApiOrder], HttpClientError>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let result = [
                TEApiOrder.init(
                    address: TEApiAddress(
                        address: "Казань, ул.Кремлевская, 35",
                        lat: 55.55,
                        lon: 100.11
                    ),
                    paymentMethod: "CARD",
                    deliverySlot: TEApiTimeSlot(
                        date: "03.05.2023",
                        timeFrom: "12:10",
                        timeTo: "13:50"
                    ),
                    items: [
                        .init(name: "Чайник", price: 3500),
                        .init(name: "Чайник", price: 2500)
                    ],
                    comment: "Позвонить за полчаса",
                    status: "NEW",
                    id: 1)
            ]
            completion(.success(result))
        }
    }
    
    func createOrder(
        reqest: OrderCreateRequest,
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(true))
        }
    }
    
    func updateOrder(
        request: OrderUpdateRequest,
        orderId: Int,
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(true))
        }
    }
    
    func getSlots(
        completion: @escaping (Result<[TEApiTimeSlot], HttpClientError>) -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let result = [
                TEApiTimeSlot(date: "2023-04-26", timeFrom: "12:00", timeTo: "14:00"),
                TEApiTimeSlot(date: "2023-04-27", timeFrom: "14:00", timeTo: "16:00"),
                TEApiTimeSlot(date: "2023-04-28", timeFrom: "10:00", timeTo: "12:00")
            ]
            completion(.success(result))
        }
    }
}
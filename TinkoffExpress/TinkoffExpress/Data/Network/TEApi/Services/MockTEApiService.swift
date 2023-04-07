//
//  MockTEApiService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.04.2023.
//

import Combine

class MockTEApiService: TEApiServiceProtocol {
    func test() -> Future<Bool, HttpClientError> {
        return Future<Bool, HttpClientError> { promise in
            promise(.success(true))
        }
    }
    
    func getOrders() -> Future<[Order], HttpClientError> {
        let result = [
            Order.init(
                address: Address(address: "Казань, ул.Кремлевская, 35", lat: 55.55, lon: 100.11),
                paymentMethod: PaymentMethod(type: PaymentMethodType.CARD),
            deliverySlot: TimeSlot(date: "03.05.2023", timeFrom: "12:10", timeTo: "13:50"),
                items: [
                    .init(name: "Чайник", price: 3500),
                    .init(name: "Чайник", price: 2500)
                ],
            comment: "Позвонить за полчаса",
            status: "NEW",
            id: 1)
        ]
        return Future<[Order], HttpClientError> { promise in
            promise(.success(result))
        }
    }
    
    func createOrder(reqest: OrderCreateRequest) -> Future<Bool, HttpClientError> {
        return Future<Bool, HttpClientError> { promise in
            promise(.success(true))
        }
    }
    
    func updateOrder(request: OrderUpdateRequest, orderId: Int) -> Future<Bool, HttpClientError> {
        return Future<Bool, HttpClientError> { promise in
            promise(.success(true))
        }
    }
    
    func getSlots() -> Future<[TimeSlot], HttpClientError> {
        let result = [
            TimeSlot(date: "2023-04-26", timeFrom: "12:00", timeTo: "14:00"),
            TimeSlot(date: "2023-04-27", timeFrom: "14:00", timeTo: "16:00"),
            TimeSlot(date: "2023-04-28", timeFrom: "10:00", timeTo: "12:00")
        ]
        return Future<[TimeSlot], HttpClientError> { promise in
            promise(.success(result))
        }
    }
}

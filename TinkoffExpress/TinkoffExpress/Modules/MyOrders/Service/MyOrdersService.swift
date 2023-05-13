//
//  MyOrdersService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import Foundation

protocol MyOrdersService {
    func loadItems(completion: @escaping ((orders: [TEApiOrder], flag: Bool)) -> Void)
}

final class RestMyOrdersService: MyOrdersService {
    // MARK: Dependency
    
    private let networkService: TEApiService
    
    // MARK: Init
    
    init(networkService: TEApiService) {
        self.networkService = networkService
    }
    
    func loadItems(completion: @escaping ((orders: [TEApiOrder], flag: Bool)) -> Void) {
        networkService.getOrders { result in
            switch result {
            case .success(let orders):
                let filteredOrders = orders.filter { $0.status != .cancelled }
                completion((filteredOrders, true))
            case .failure:
                completion(([], false))
            }
        }
    }
}

final class MockMyOrdersService: MyOrdersService {
    func loadItems(completion: @escaping ((orders: [TEApiOrder], flag: Bool)) -> Void) {
        let orders: [TEApiOrder] = [
            .init(
                address: TEApiAddress(address: "Казань, ул. Кремлевская, 35", lat: 0, lon: 0),
                paymentMethod: .cash,
                deliverySlot: TEApiTimeSlot(date: "2023-05-11", timeFrom: "12:00", timeTo: "14:00"),
                items: [],
                comment: "",
                status: .created,
                id: 1
            ),
            .init(
                address: TEApiAddress(address: "Казань, ул. Кремлевская, 35", lat: 0, lon: 0),
                paymentMethod: .cash,
                deliverySlot: TEApiTimeSlot(date: "2023-05-12", timeFrom: "14:00", timeTo: "16:00"),
                items: [],
                comment: "",
                status: .created,
                id: 1
            )
        ]
        completion((orders, true))
    }
}

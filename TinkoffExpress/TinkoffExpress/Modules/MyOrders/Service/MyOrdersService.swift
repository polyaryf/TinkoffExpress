//
//  MyOrdersService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import Foundation

protocol MyOrdersService {
    func loadItems(completion: @escaping ([TEApiOrder]) -> Void)
}

final class RestMyOrdersService: MyOrdersService {
    // MARK: Dependency
    
    private let networkService: TEApiService
    
    // MARK: Init
    
    init(networkService: TEApiService) {
        self.networkService = networkService
    }
    
    func loadItems(completion: @escaping ([TEApiOrder]) -> Void) {
        networkService.getOrders { result in
            switch result {
            case .success(let orders):
                let filteredOrders = orders.filter { $0.status != .cancelled }
                completion(filteredOrders)
            case .failure:
                completion([])
            }
        }
    }
}
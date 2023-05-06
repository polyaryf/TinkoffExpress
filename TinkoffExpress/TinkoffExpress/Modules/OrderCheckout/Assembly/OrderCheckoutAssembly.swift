//
//  OrderCkeckoutAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol IOrderCheckoutAssembly {
    func createOrderCheckoutView(withModuleType type: OrderCheckoutModuleType) -> UIViewController
}

final class OrderCheckoutAssembly: IOrderCheckoutAssembly {
    func createOrderCheckoutView(withModuleType type: OrderCheckoutModuleType) -> UIViewController {
        let networkService = TEApiService()
        let mockService = MockOrderCheckoutService()
        let restService = RestOrderCheckoutService(networkService: networkService)
        let mapper = OrderCheckoutMapper()
        let presenter = OrderCheckoutPresenter(
            service: restService,
            mapper: mapper,
            type: type
        )
        let viewController = OrderCheckoutViewController(orderCheckoutPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

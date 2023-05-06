//
//  OrderCkeckoutAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol IOrderCheckoutAssembly {
    func createOrderCheckoutView(
        withModuleType type: OrderCheckoutModuleType,
        with model: OrderCheckout
    ) -> UIViewController
}

final class OrderCheckoutAssembly: IOrderCheckoutAssembly {
    func createOrderCheckoutView(
        withModuleType type: OrderCheckoutModuleType,
        with model: OrderCheckout
    ) -> UIViewController {
        let networkService = TEApiService()
        let mockService = MockOrderCheckoutService()
        let restService = RestOrderCheckoutService(networkService: networkService)
        let router = OrderCheckoutRouter(finalDeliveryAssembly: FinalDeliveryAssembly())
        let mapper = OrderCheckoutMapper()
        let presenter = OrderCheckoutPresenter(
            router: router,
            service: restService,
            mapper: mapper,
            type: type,
            item: model
        )
        let viewController = OrderCheckoutViewController(orderCheckoutPresenter: presenter)
        presenter.view = viewController
        router.transitionHandler = viewController
        return viewController
    }
}

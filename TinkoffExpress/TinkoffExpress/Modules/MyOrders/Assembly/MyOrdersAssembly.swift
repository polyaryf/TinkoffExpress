//
//  MyOrdersAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import UIKit

protocol IMyOrdersAssembly {
    func createMyOrdersView() -> UIViewController
}

final class MyOrdersAssembly: IMyOrdersAssembly {
    func createMyOrdersView() -> UIViewController {
        let network = TEApiService()
        let restService = RestMyOrdersService(networkService: network)
        let mockService = MockMyOrdersService()
        let router = MyOrdersRouter(orderCheckoutAssembly: OrderCheckoutAssembly())
        let presenter = MyOrdersPresenter(
            router: router,
            service: mockService,
            formatter: TEDateFormatter(),
            notifier: TEOrdersNotificationsService.shared
        )
        let viewController = MyOrdersViewController(myOrdersPresenter: presenter)
        presenter.view = viewController
        router.transitionHandler = viewController
        return viewController
    }
}

//
//  OrderCkeckoutAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol IOrderCheckoutAssembly {
    func createOrderCheckoutView(with inputModel: NewOrderInputModel) -> UIViewController
    func createOrderCheckoutView(with order: TEApiOrder) -> UIViewController
}

final class OrderCheckoutAssembly: IOrderCheckoutAssembly {
    func createOrderCheckoutView(with inputModel: NewOrderInputModel) -> UIViewController {
        createView(withType: .creatingOrder(inputModel))
    }

    func createOrderCheckoutView(with order: TEApiOrder) -> UIViewController {
        createView(withType: .editingOrder(order))
    }

    private func createView(withType type: OrderCheckoutModuleType) -> UIViewController {
        let networkService = TEApiService()
        let restService = RestOrderCheckoutService(networkService: networkService)
        let router = OrderCheckoutRouter(finalDeliveryAssembly: FinalDeliveryAssembly())
        let mapper = OrderCheckoutMapper()

        let presenter = OrderCheckoutPresenter(
            router: router,
            service: restService,
            mapper: mapper,
            type: type,
            dateFormatter: TEDateFormatter(),
            listener: TEOrdersNotificationsService.shared
        )

        let viewController = OrderCheckoutViewController(orderCheckoutPresenter: presenter)
        presenter.view = viewController
        router.transitionHandler = viewController
        return viewController
    }
}

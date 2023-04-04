//
//  OrderCkeckoutAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

final class OrderCkeckoutAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let mockService = MockOrderCheckoutService()
        let presenter = OrderCheckoutPresenter(coordinator: coordinator, service: mockService)
        let viewController = OrderCheckoutViewController(orderCheckoutPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

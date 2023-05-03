//
//  OrderCkeckoutAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol IOrderCheckoutAssembly {
    func createOrderCheckoutView() -> UIViewController
}

final class OrderCheckoutAssembly: IOrderCheckoutAssembly {
    func createOrderCheckoutView() -> UIViewController {
        let networkService = TEApiService()
        let mockService = MockOrderCheckoutService()
        let restService = RestOrderCheckoutService(networkService: networkService)
        let presenter = OrderCheckoutPresenter(service: restService)
        let viewController = OrderCheckoutViewController(orderCheckoutPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

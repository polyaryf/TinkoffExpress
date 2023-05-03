//
//  MyOrdersAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import UIKit

final class MyOrdersAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let mockService = MockMyOrdersService()
        let presenter = MyOrdersPresenter(coordinator: coordinator, service: mockService)
        let viewController = MyOrdersViewController(myOrdersPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

//
//  MyOrdersAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import UIKit

protocol IMyOrdersAssembly {
    func createMyOrdersView(coordinator: Coordinator, output: IMyOrdersModuleOutput) -> UIViewController
}

final class MyOrdersAssembly: IMyOrdersAssembly, Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let mockService = MockMyOrdersService()
        let presenter = MyOrdersPresenter(
            coordinator: coordinator,
            service: mockService
        )
        let viewController = MyOrdersViewController(myOrdersPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
    
    func createMyOrdersView(coordinator: Coordinator, output: IMyOrdersModuleOutput) -> UIViewController {
        let mockService = MockMyOrdersService()
        let presenter = MyOrdersPresenter(
            coordinator: coordinator,
            service: mockService
        )
        let viewController = MyOrdersViewController(myOrdersPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

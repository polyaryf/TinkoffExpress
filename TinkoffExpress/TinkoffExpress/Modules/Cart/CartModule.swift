//
//  CartModule.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import Foundation

class CartModule: Module {
    static func createViewController(coordinator: AppCoordinator) -> Modulated {
        let viewController = CartViewController()
        let mockService = MockCartService()
        let presenter = CartPresenter(coordinator: coordinator, view: viewController, service: mockService)
        viewController.setPresenter(presenter)
        return viewController
    }
}

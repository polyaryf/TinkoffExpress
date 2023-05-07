//
//  CartAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

final class CartAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let mockService = MockCartService()
        let presenter = CartPresenter(coordinator: coordinator, service: mockService)
        let viewController = CartViewController(cartPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

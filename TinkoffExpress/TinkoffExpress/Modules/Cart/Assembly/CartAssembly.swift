//
//  CartAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

final class CartAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let service = CartService.shared
        let presenter = CartPresenter( service: service)
        let viewController = CartViewController(cartPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

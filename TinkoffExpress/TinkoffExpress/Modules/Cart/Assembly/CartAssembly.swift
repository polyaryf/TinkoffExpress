//
//  CartAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

protocol ICartAssembly {
    func createCartView() -> UIViewController
}

final class CartAssembly: ICartAssembly {
    func createCartView() -> UIViewController {
        let service = CartService.shared
        let router = CartRouter(deliveryAssembly: DeliveryAssembly())
        let presenter = CartPresenter( service: service, router: router)
        let viewController = CartViewController(cartPresenter: presenter)
        presenter.view = viewController
        router.transitionHandler = viewController
        return viewController
    }
}

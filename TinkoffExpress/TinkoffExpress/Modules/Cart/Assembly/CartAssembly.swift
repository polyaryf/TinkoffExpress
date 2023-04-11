//
//  CartAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

final class CartAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let network = TEApiService() as TEOrderApiProtocol
        let restService = RestCartService(networkService: network)
        let presenter = CartPresenter(coordinator: coordinator, service: restService)
        let viewController = CartViewController(cartPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

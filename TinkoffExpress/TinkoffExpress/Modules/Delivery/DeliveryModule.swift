//
//  DeliveryModule.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import Foundation

class DeliveryModule: Module {
    static func createViewController(coordinator: AppCoordinator) -> Modulated {
        let viewController = DeliveryViewController()
        let mockService = MockDeliveryService()
        let presenter = DeliveryPresenter(coordinator: coordinator, view: viewController, service: mockService)
        viewController.setPresenter(presenter)
        return viewController
    }
}

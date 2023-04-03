//
//  DeliveryAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

final class DeliveryAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let mockService = MockDeliveryService()
        let presenter = DeliveryPresenter(coordinator: coordinator, service: mockService)
        let viewController = DeliveryViewController(deliveryPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

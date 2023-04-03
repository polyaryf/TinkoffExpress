//
//  FinalDeliveryAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

final class FinalDeliveryAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let mockService = MockFinalDeliveryService()
        let presenter = FinalDeliveryPresenter(coordinator: coordinator, service: mockService)
        let viewController = FinalDeliveryViewController(finalDeliveryPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

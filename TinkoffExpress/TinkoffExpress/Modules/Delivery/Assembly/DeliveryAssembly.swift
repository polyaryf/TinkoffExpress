//
//  DeliveryAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

protocol IDeliveryAssembly {
    func createDeliveryView() -> UIViewController
}

final class DeliveryAssembly: IDeliveryAssembly {
    func createDeliveryView() -> UIViewController {
        let mockService = MockDeliveryService()
        let router = DeliveryRouter(onboardingAssembly: OnboardingAssembly())
        let presenter = DeliveryPresenter(service: mockService, router: router)
        let viewController = DeliveryViewController(deliveryPresenter: presenter)
        presenter.view = viewController
        router.transitionHandler = viewController
        return viewController
    }
}

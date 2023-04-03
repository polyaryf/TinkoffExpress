//
//  OnboardingAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

final class OnboardingAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let mockService = MockOnboardingService()
        let presenter = OnboardingPresenter(coordinator: coordinator, service: mockService)
        let viewController = OnboardingViewController(onboardingPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

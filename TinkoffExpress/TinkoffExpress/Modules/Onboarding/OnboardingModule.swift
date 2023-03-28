//
//  OnboardingModule.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

class OnboardingModule: Module {
    static func createViewController(coordinator: AppCoordinator) -> UIViewController {
        let viewController = OnboardingViewController()
        let mockService = MockOnboardingService()
        let presenter = OnboardingPresenter(coordinator: coordinator, view: viewController, service: mockService)
        viewController.setPresenter(presenter)
        return viewController
    }
}

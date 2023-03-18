//
//  DependencyFactory.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import Foundation

protocol Factory {
    func makeInitialViewController(coordinator: AppCoordinator) -> CartViewController
    func makeCartViewController(coordinator: AppCoordinator) -> CartViewController
    func makeDeliveryViewController(coordinator: AppCoordinator) -> DeliveryViewController
    func makeOnboardingViewController(coordinator: AppCoordinator) -> OnboardingViewController
}

class DependencyFactory: Factory {
    struct Dependencies {
        // This is for Managers
    }
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeInitialCoordinator() -> AppCoordinator {
        let coordinator = AppCoordinator(factory: self)
        return coordinator
    }
    
    // MARK: Creating ViewControllers
    
    func makeInitialViewController(coordinator: AppCoordinator) -> CartViewController {
        makeCartViewController(coordinator: coordinator)
    }
    
    func makeCartViewController(coordinator: AppCoordinator) -> CartViewController {
        let viewController = CartViewController()
        let presenter = CartPresenter(coordinator: coordinator, view: viewController)
        viewController.setPresenter(presenter)
        return viewController
    }
    
    func makeDeliveryViewController(coordinator: AppCoordinator) -> DeliveryViewController {
        let viewController = DeliveryViewController()
        let presenter = DeliveryPresenter(coordinator: coordinator, view: viewController)
        viewController.setPresenter(presenter)
        return viewController
    }
    
    func makeOnboardingViewController(coordinator: AppCoordinator) -> OnboardingViewController {
        let viewController = OnboardingViewController()
        let presenter = OnboardingPresenter(coordinator: coordinator, view: viewController)
        viewController.setPresenter(presenter)
        return viewController
    }
}

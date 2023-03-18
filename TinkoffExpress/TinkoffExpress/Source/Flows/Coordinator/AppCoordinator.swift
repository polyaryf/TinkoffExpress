//
//  AppCoordinator.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit

class AppCoordinator: AbstractCoordinator, RootCoordinator {
    private(set) var childCoordinators: [AbstractCoordinator] = []
    weak var navigationController: UINavigationController?
    private var factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
    }
    
    func addChildCoordinator(_ coordinator: AbstractCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}


// MARK: - Navigation
extension AppCoordinator {
    func start(_ navigationController: UINavigationController) {
        let viewController = factory.makeInitialViewController(coordinator: self)
        self.navigationController = navigationController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToCart() {
        let viewController = factory.makeCartViewController(coordinator: self)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func moveToDelivery() {
        let childCoordinator = AppCoordinator(factory: factory)
        addChildCoordinator(childCoordinator)
        
        let viewController = factory.makeDeliveryViewController(coordinator: childCoordinator)
        let navController = UINavigationController(rootViewController: viewController)
        
        childCoordinator.navigationController = navController
        navigationController?.present(navController, animated: true)
    }
    
    func moveToOnboarding() {
        let viewController = factory.makeOnboardingViewController(coordinator: self)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func moveToDestination() {
        // TODO: Get from factory DestinationViewController
        // TODO: Push to navigationController DestinationViewController
    }
}

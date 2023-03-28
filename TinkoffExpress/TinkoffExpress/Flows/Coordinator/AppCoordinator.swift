//
//  AppCoordinator.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
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
    
    // MARK: Navigation
    
    func start(_ navigationController: UINavigationController) {
        // swiftlint:disable:next superfluous_disable_command
        let viewController = factory.makeViewController(coordinator: self, module: CartModule.self)
        // swiftlint:disable:next force_cast
        as! CartViewController
        self.navigationController = navigationController
        navigationController.pushViewController(viewController, animated: true)
    }
}

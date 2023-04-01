//
//  Coordinator.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func start(_ navigationController: UINavigationController)
    func move(_ assembly: Assembly, with typeOfNavigation: TypeOfNaviation)
}

final class AppCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    
    func start(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        move(CartAssembly(), with: .push)
    }
    
    func move(_ assembly: Assembly, with typeOfNavigation: TypeOfNaviation) {
        switch typeOfNavigation {
        case .push:
            let viewController = assembly.createViewController(coordinator: self)
            navigationController?.pushViewController(viewController, animated: true)
        case .present:
            let childCoordinator = AppCoordinator()
            
            let viewController = assembly.createViewController(coordinator: childCoordinator)
            let childNavigationController = UINavigationController(rootViewController: viewController)
            
            childCoordinator.navigationController = childNavigationController
            navigationController?.present(childNavigationController, animated: true)
        }
    }
}

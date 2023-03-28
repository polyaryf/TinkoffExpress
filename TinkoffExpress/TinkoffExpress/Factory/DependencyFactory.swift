//
//  DependencyFactory.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

protocol Factory {
    func makeViewController(coordinator: AppCoordinator, module: Module.Type) -> UIViewController
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
    
    // MARK: Creating ViewController
    
    func makeViewController(coordinator: AppCoordinator, module: Module.Type) -> UIViewController {
        return module.createViewController(coordinator: coordinator)
    }
}

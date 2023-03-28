//
//  DependencyFactory.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import Foundation

protocol Factory {
    func makeViewController(coordinator: AppCoordinator, module: Module.Type) -> Modulated
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
    
    func makeViewController(coordinator: AppCoordinator, module: Module.Type) -> Modulated {
        return module.createViewController(coordinator: coordinator)
    }
}

//
//  Coordinator.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var isRootCoordinator: Bool { get }
    
    func start(_ navigationController: UINavigationController)
    func move(_ assembly: Assembly, with typeOfNavigation: TypeOfNavigation)
}

final class AppCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    var isRootCoordinator = true
    
    func start(_ navigationController: UINavigationController) {
        guard isRootCoordinator else { return }
        self.navigationController = navigationController
        
        setupTabBar(assemblages: [CartAssembly(), CartAssembly()])
    }
    
    func move(_ assembly: Assembly, with typeOfNavigation: TypeOfNavigation) {
        switch typeOfNavigation {
        case .push:
            let viewController = assembly.createViewController(coordinator: self)
            navigationController?.pushViewController(viewController, animated: true)
        case .present:
            let childCoordinator = AppCoordinator()
            childCoordinator.isRootCoordinator = false
            
            let viewController = assembly.createViewController(coordinator: childCoordinator)
            let childNavigationController = UINavigationController(rootViewController: viewController)
            
            childCoordinator.navigationController = childNavigationController
            navigationController?.present(childNavigationController, animated: true)
        case .set:
            let viewController = assembly.createViewController(coordinator: self)
            navigationController?.setViewControllers([viewController], animated: true)
        }
    }
    
    private func setupTabBar(assemblages: [Assembly]) {
        let tabBarController = UITabBarController()
        var viewControllers: [UIViewController] = []
        
        for i in 0..<assemblages.count {
            let vc = assemblages[i].createViewController(coordinator: self)
            let navController = UINavigationController(rootViewController: vc)
            navController.tabBarItem = getTabBarItem(with: i)
            viewControllers.append(navController)
        }
        
        tabBarController.viewControllers = viewControllers
        navigationController?.setViewControllers([tabBarController], animated: true)
    }
    
    private func getTabBarItem(with index: Int) -> UITabBarItem {
        let titles: [String] = ["Корзина", "Мои заказы"]
        let imageNames: [String] = ["cartTabBarItemImage", "myOrdersTabBarItemImage"]
        return UITabBarItem(title: titles[index], image: UIImage(named: imageNames[index]), tag: index)
    }
}

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
        
        setupTabBar()
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
    
    private func setupTabBar() {
        let tabBarController = UITabBarController()
        var viewControllers: [UIViewController] = []
        
        let cartController = UINavigationController(
            rootViewController: CartAssembly().createViewController(coordinator: self)
        )
        let myOrdersController = UINavigationController(rootViewController: MyOrdersAssembly().createMyOrdersView())
        let settingsController = UINavigationController(
            rootViewController: SettingsAssembly().createViewController(coordinator: self)
        )
        cartController.tabBarItem = getTabBarItem(with: 0)
        myOrdersController.tabBarItem = getTabBarItem(with: 1)
        settingsController.tabBarItem = getTabBarItem(with: 2)
        
        viewControllers.append(cartController)
        viewControllers.append(myOrdersController)
        viewControllers.append(settingsController)
        
        tabBarController.viewControllers = viewControllers
        navigationController?.setViewControllers([tabBarController], animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func getTabBarItem(with index: Int) -> UITabBarItem {
        let titles: [String] = ["Корзина", "Мои заказы", "Настройки"]
        let imageNames: [String] = ["cartTabBarItemImage", "myOrdersTabBarItemImage", "myOrdersTabBarItemImage"]
        return UITabBarItem(title: titles[index], image: UIImage(named: imageNames[index]), tag: index)
    }
}

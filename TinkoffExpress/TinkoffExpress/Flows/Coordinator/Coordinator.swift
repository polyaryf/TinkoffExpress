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
}

final class AppCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    var isRootCoordinator = true
    
    func start(_ navigationController: UINavigationController) {
        guard isRootCoordinator else { return }
        self.navigationController = navigationController
        
        setupTabBar()
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
        let catalogController = UINavigationController(rootViewController: CatalogAssembly().createCatalogView())
        catalogController.tabBarItem = getTabBarItem(with: 0)
        cartController.tabBarItem = getTabBarItem(with: 1)
        myOrdersController.tabBarItem = getTabBarItem(with: 2)
        settingsController.tabBarItem = getTabBarItem(with: 3)
        
        viewControllers.append(catalogController)
        viewControllers.append(cartController)
        viewControllers.append(myOrdersController)
        viewControllers.append(settingsController)
        
        tabBarController.viewControllers = viewControllers
        navigationController?.setViewControllers([tabBarController], animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func getTabBarItem(with index: Int) -> UITabBarItem {
        let titles: [String] = ["Каталог", "Корзина", "Мои заказы", "Настройки"]
        let imageNames: [String] = ["catalogTabBarItemImage", "cartTabBarItemImage", "myOrdersTabBarItemImage"]
        if index == 3 {
            return UITabBarItem(title: titles[index], image: UIImage(systemName: "gear"), tag: index)
        }
        return UITabBarItem(title: titles[index], image: UIImage(named: imageNames[index]), tag: index)
    }
}

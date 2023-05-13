//
//  Coordinator.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit
import Combine

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var isRootCoordinator: Bool { get }
    
    func start(_ navigationController: UINavigationController)
}

final class AppCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    var isRootCoordinator = true
    
    // MARK: State
    
    private let service: ICartService = CartService.shared
    private var cancellables: Set<AnyCancellable> = []
    private let tabBarController = UITabBarController()
    private var viewControllers: [UIViewController] = []
    
    func start(_ navigationController: UINavigationController) {
        guard isRootCoordinator else { return }
        self.navigationController = navigationController
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        setupCatalogController()
        setupCartController()
        setupMyOrdersController()
        setupSettingsController()
        
        tabBarController.viewControllers = viewControllers
        navigationController?.setViewControllers([tabBarController], animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupCatalogController() {
        let catalogController = UINavigationController(rootViewController: CatalogAssembly().createCatalogView())
        catalogController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("tabBarCatalog", comment: ""),
            image: UIImage(named: "catalogTabBarItemImage"),
            tag: 0
        )
        
        viewControllers.append(catalogController)
    }
    
    private func setupCartController() {
        let cartController = UINavigationController(
            rootViewController: CartAssembly().createCartView()
        )
        let cartTabBarItem = UITabBarItem(
            title: NSLocalizedString("tabBarCart", comment: ""),
            image: UIImage(named: "cartTabBarItemImage"),
            tag: 1
        )
        cartTabBarItem.badgeColor = UIColor(named: "yellowButtonColor")
        cartTabBarItem.setBadgeTextAttributes(
            [.foregroundColor: UIColor(named: "badgeColor")],
            for: .normal
        )
        
        cartController.tabBarItem = cartTabBarItem
        viewControllers.append(cartController)
        
        service.currentProductsPublisher.sink { [weak self] cartProducts in
            var totalCount = 0
            cartProducts.forEach { cart in
                totalCount += Int(cart.counter)
            }
            if totalCount == 0 {
                self?.tabBarController.tabBar.items?[1].badgeValue = nil
            } else {
                self?.tabBarController.tabBar.items?[1].badgeValue = "\(totalCount)"
            }
        }
        .store(in: &cancellables)
    }
    
    private func setupMyOrdersController() {
        let myOrdersController = UINavigationController(rootViewController: MyOrdersAssembly().createMyOrdersView())
        myOrdersController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("tabBarMyOrders", comment: ""),
            image: UIImage(named: "myOrdersTabBarItemImage"),
            tag: 2
        )
        
        viewControllers.append(myOrdersController)
    }
    
    private func setupSettingsController() {
        let settingsController = UINavigationController(
            rootViewController: SettingsAssembly().createSettingsView()
        )
        settingsController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("tabBarSettings", comment: ""),
            image: UIImage(systemName: "gear"),
            tag: 3
        )

        viewControllers.append(settingsController)
    }
}

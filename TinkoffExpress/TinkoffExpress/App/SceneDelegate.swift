//
//  SceneDelegate.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 16.03.2023.
//

import UIKit
import Reachability

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: Coordinator?
        
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = TinkoffExpressWindow(windowScene: windowScene)

        let rootNavigationController = UINavigationController()
        
        coordinator = AppCoordinator()
        coordinator?.start(rootNavigationController)
        
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}

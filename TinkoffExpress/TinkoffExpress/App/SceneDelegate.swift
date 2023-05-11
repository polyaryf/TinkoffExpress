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
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let rootController = TinkoffExpressViewController()
        let childController = UINavigationController()
        
        rootController.view.addSubview(childController.view)
        
        rootController.addChild(childController)
        
        coordinator = AppCoordinator()
        coordinator?.start(childController)
        
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}

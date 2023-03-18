//
//  SceneDelegate.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let rootNavigationController = UINavigationController()
        let container = DependencyFactory(dependencies: .init())
        let coordinator = container.makeInitialCoordinator()
        
        coordinator.start(rootNavigationController)
        
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}

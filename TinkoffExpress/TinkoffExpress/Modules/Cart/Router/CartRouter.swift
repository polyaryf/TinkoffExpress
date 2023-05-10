//
//  CartRouter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.05.2023.
//

import UIKit

protocol ICartRouter {
    func openDelivery()
}

final class CartRouter: ICartRouter {
    // MARK: Dependencies
   
    weak var transitionHandler: UIViewController?
    private let deliveryAssembly: IDeliveryAssembly
    
    // MARK: Init
    
    init(deliveryAssembly: IDeliveryAssembly) {
        self.deliveryAssembly = deliveryAssembly
    }
    
    // MARK: ICartRouter
    
    func openDelivery() {
        let deliveryView = deliveryAssembly.createDeliveryView()
        let navigationController = UINavigationController(rootViewController: deliveryView)
        transitionHandler?.navigationController?.present(navigationController, animated: true)
    }
}

//
//  OrderCheckoutRouter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 06.05.2023.
//

import UIKit

protocol IOrderCheckoutRouter {
    func openFinalDelivery(with model: FinalDelivery)
}

final class OrderCheckoutRouter: IOrderCheckoutRouter {
    // MARK: Dependencies

    weak var transitionHandler: UIViewController?
    private let finalDeliveryAssembly: IFinalDelivaryAssembly
    
    // MARK: Init
    
    init(finalDeliveryAssembly: IFinalDelivaryAssembly) {
        self.finalDeliveryAssembly = finalDeliveryAssembly
    }
    
    // MARK: IOrderCheckoutRouter
    
    func openFinalDelivery(with model: FinalDelivery) {
        let finalDeliveryView = finalDeliveryAssembly.createFinalDeliveryView(with: model)
        transitionHandler?.navigationController?.setViewControllers([finalDeliveryView], animated: true)
    }
}

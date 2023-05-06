//
//  MyOrdersRouter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 06.05.2023.
//

import UIKit

protocol IMyOrdersRouter {
    func openOrderCheckout(with model: OrderCheckout)
}

final class MyOrdersRouter: IMyOrdersRouter {
    // MARK: Dependencies

    weak var transitionHandler: UIViewController?
    private let orderCheckoutAssembly: IOrderCheckoutAssembly
    
    // MARK: Init
    
    init(orderCheckoutAssembly: IOrderCheckoutAssembly) {
        self.orderCheckoutAssembly = orderCheckoutAssembly
    }
    
    // MARK: IMyOrdersRouter
    
    func openOrderCheckout(with model: OrderCheckout) {
        let orderCheckoutView = orderCheckoutAssembly.createOrderCheckoutView(
            withModuleType: .editingOrder,
            with: model
        )
        orderCheckoutView.hidesBottomBarWhenPushed = true
        transitionHandler?.navigationController?.pushViewController(orderCheckoutView, animated: true)
    }
}

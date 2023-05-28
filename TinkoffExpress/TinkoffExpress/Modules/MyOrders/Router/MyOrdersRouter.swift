//
//  MyOrdersRouter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 06.05.2023.
//

import UIKit

protocol IMyOrdersRouter {
    func openOrderCheckout(with model: TEApiOrder)
    func openRating()
}

final class MyOrdersRouter: IMyOrdersRouter {
    // MARK: Dependencies

    weak var transitionHandler: UIViewController?
    private let orderCheckoutAssembly: IOrderCheckoutAssembly
    private let ratingAssembly: IRatingAssembly
    
    // MARK: Init
    
    init(
        orderCheckoutAssembly: IOrderCheckoutAssembly,
        ratingAssembly: IRatingAssembly
    ) {
        self.orderCheckoutAssembly = orderCheckoutAssembly
        self.ratingAssembly = ratingAssembly
    }
    
    // MARK: IMyOrdersRouter
    
    func openOrderCheckout(with model: TEApiOrder) {
        let orderCheckoutView = orderCheckoutAssembly.createOrderCheckoutView(
            with: model
        )
        orderCheckoutView.hidesBottomBarWhenPushed = true
        transitionHandler?.navigationController?.pushViewController(orderCheckoutView, animated: true)
    }
    
    func openRating() {
        let ratingView = ratingAssembly.createRatingView()
        ratingView.modalPresentationStyle = .custom
        ratingView.transitioningDelegate = transitionHandler.self as? any UIViewControllerTransitioningDelegate
        transitionHandler?.present(ratingView, animated: true, completion: nil)
    }
}

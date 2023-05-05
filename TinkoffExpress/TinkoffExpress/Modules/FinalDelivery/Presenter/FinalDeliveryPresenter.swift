//
//  FinalDeliveryPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol FinalDeliveryPresenterProtocol {
    func viewDidLoad()
    func okButtonTapped()
}

class FinalDeliveryPresenter: FinalDeliveryPresenterProtocol {
    // MARK: Dependency
    
    weak var view: FinalDeliveryViewController?
    
    // MARK: State
    
    private var item: FinalDelivery?
    
    // MARK: FinalDeliveryPresenterProtocol
    
    func viewDidLoad() {
        guard let item else { return }
        view?.item = item
    }
    
    func okButtonTapped() {
        showCart()
    }
    
    // MARK: Navigation
    
    private func showCart() {
        // TODO: move to start
    }
}

extension FinalDeliveryPresenter: IOrderCheckoutModuleOutput {
    func orderCheckout(didCompleteWith orderData: OrderCheckout) {
        let finalItem = FinalDelivery(
            where: orderData.deliveryWhere,
            when: orderData.deliveryWhen,
            what: orderData.whatWillBeDelivered)
        self.item = finalItem
    }
}

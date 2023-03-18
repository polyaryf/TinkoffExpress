//
//  CartPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import Foundation

protocol CartPresenterProtocol {
    func checkoutButtonTapped()
}

class CartPresenter: CartPresenterProtocol {
    weak private var view: CartViewController?
    private var coordinator: AppCoordinator?

    // Initialization
    init(coordinator: AppCoordinator, view: CartViewController) {
        self.coordinator = coordinator
        self.view = view
    }
}


// MARK: - Event
extension CartPresenter {
    func checkoutButtonTapped() {
        showDelivery()
    }
}


// MARK: - Navigation
extension CartPresenter {
    private func showDelivery() {
        coordinator?.moveToDelivery()
    }
}

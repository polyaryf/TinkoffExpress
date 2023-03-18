//
//  CartPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import Foundation

protocol CartPresenterProtocol {
    func showDelivery()
}

class CartPresenter {
    weak private var view: CartViewController?
    private var coordinator: AppCoordinator?

    // Initialization
    init(coordinator: AppCoordinator, view: CartViewController) {
        self.coordinator = coordinator
        self.view = view
    }
}

// MARK: - Navigation
extension CartPresenter: CartPresenterProtocol {
    func showDelivery() {
        coordinator?.moveToDelivery()
    }
}

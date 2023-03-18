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
    // MARK: Dependencies
    
    weak private var view: CartViewController?
    private var coordinator: AppCoordinator?

    // MARK: Init
    init(coordinator: AppCoordinator, view: CartViewController) {
        self.coordinator = coordinator
        self.view = view
    }
    
    // MARK: Events
    
    func checkoutButtonTapped() {
        showDelivery()
    }
    
    // MARK: Navigation
    
    private func showDelivery() {
        coordinator?.moveToDelivery()
    }
}

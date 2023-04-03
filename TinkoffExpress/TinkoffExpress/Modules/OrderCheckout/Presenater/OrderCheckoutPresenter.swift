//
//  OrderCheckoutPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol OrderCheckoutPresenterProtocol {
    func checkoutButtonTapped()
}

class OrderCheckoutPresenter: OrderCheckoutPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: OrderCheckoutViewController?
    private var coordinator: Coordinator?
    private var service: OrderCheckoutService?
    
    // MARK: Init
    init(coordinator: Coordinator, service: OrderCheckoutService) {
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: Events
    
    func checkoutButtonTapped() {
        showFinalDelivery()
    }
    
    // MARK: Navigation
    
    private func showFinalDelivery() {
        // TODO: coordinator?.move(FinalDeliveryAssembly(), with: .push)
    }
}

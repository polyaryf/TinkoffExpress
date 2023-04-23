//
//  FinalDeliveryPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol FinalDeliveryPresenterProtocol {
    func okButtonTapped()
}

class FinalDeliveryPresenter: FinalDeliveryPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: FinalDeliveryViewController?
    private var coordinator: Coordinator?
    private var service: FinalDeliveryService?
    
    // MARK: Init
    
    init(coordinator: Coordinator, service: FinalDeliveryService) {
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: Events
    
    func okButtonTapped() {
        showCart()
    }
    
    // MARK: Navigation
    
    private func showCart() {
        coordinator?.move(CartAssembly(), with: .push)
    }
}

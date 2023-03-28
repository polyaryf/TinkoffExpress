//
//  CartPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import Foundation

protocol CartPresenterProtocol {
    func viewDidLoad()
    func checkoutButtonTapped()
}

class CartPresenter: CartPresenterProtocol {
    // MARK: Dependencies
    
    weak private var view: CartViewController?
    private var coordinator: AppCoordinator?
    private var service: CartService?

    // MARK: Init
    init(coordinator: AppCoordinator, view: CartViewController, service: CartService) {
        self.coordinator = coordinator
        self.view = view
        self.service = service
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        service?.loadItems { [weak self] items in
            guard let self = self else { return }
            self.view?.items = items ?? []
        }
    }
    
    // MARK: Events
    
    func checkoutButtonTapped() {
        showDelivery()
    }
    
    private func showDelivery() {
        coordinator?.moveToDelivery()
    }
}

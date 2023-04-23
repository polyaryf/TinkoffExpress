//
//  MyOrdersPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import Foundation

protocol MyOrdersPresenterProtocol {
    func viewDidLoad()
    func didSelectItemAt()
}

final class MyOrdersPresenter: MyOrdersPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: MyOrdersViewController?
    private var coordinator: Coordinator?
    private var service: MyOrdersService?
    
    // MARK: Init
    init(coordinator: Coordinator, service: MyOrdersService) {
        self.coordinator = coordinator
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
    
    func didSelectItemAt() {
        showOrderCheckout()
    }
    
    // MARK: Navigation
    
    private func showOrderCheckout() {
        coordinator?.move(OrderCheckoutAssembly(), with: .push)
    }
}


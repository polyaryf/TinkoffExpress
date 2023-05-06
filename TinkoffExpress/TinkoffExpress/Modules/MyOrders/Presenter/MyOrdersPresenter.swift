//
//  MyOrdersPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import Foundation

protocol IMyOrdersModuleOutput: AnyObject {
    func myOrders(didCompleteWith order: MyOrder)
}

protocol MyOrdersPresenterProtocol {
    func viewDidLoad()
    func didSelect(item: MyOrder)
}

final class MyOrdersPresenter: MyOrdersPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: MyOrdersViewController?
    private var coordinator: Coordinator?
    private var service: MyOrdersService?
    
    // MARK: Init
    
    init(
        coordinator: Coordinator,
        service: MyOrdersService
    ) {
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
    
    func didSelect(item: MyOrder) {
        // TODO: add output
//        output?.myOrders(didCompleteWith order: item)
        showOrderCheckout()
    }
    
    // MARK: Navigation
    
    private func showOrderCheckout() {
        // TODO: Add navigation to OrderCheckout
    }
}

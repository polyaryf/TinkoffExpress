//
//  MyOrdersPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import Foundation

protocol MyOrdersPresenterProtocol {
    func viewDidLoad()
    func didSelect(item: MyOrder)
}

final class MyOrdersPresenter: MyOrdersPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: MyOrdersViewController?
    private let router: IMyOrdersRouter
    private let service: MyOrdersService
    
    // MARK: Init
    
    init(
        router: IMyOrdersRouter,
        service: MyOrdersService
    ) {
        self.router = router
        self.service = service
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        service.loadItems { [weak self] items in
            guard let self = self else { return }
            self.view?.updateView(with: items)
        }
    }
    
    // MARK: Events
    
    func didSelect(item: MyOrder) {
        router.openOrderCheckout(with: OrderCheckout.from(model: item))
    }
}

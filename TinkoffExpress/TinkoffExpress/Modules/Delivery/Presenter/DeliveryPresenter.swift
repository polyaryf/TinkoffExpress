//
//  DeliveryPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import Foundation

protocol DeliveryPresenterProtocol {
    func viewDidLoad()
    func didSelectItemAt()
}

final class DeliveryPresenter: DeliveryPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: DeliveryViewController?
    private let service: DeliveryService
    private let router: IDeliveryRouter
    
    // MARK: Init
    
    init(
        service: DeliveryService,
        router: IDeliveryRouter
    ) {
        self.service = service
        self.router = router
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        service.loadItems { [weak self] items in
            guard let self = self else { return }
            self.view?.items = items ?? []
        }
    }
    
    // MARK: Events
    
    func didSelectItemAt() {
        showOnboarding()
    }
    
    // MARK: Navigation
    
    private func showOnboarding() {
        router.openOnboarding()
    }
}

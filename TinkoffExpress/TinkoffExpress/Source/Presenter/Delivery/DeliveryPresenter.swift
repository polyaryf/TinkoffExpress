//
//  DeliveryPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import Foundation

protocol DeliveryPresenterProtocol {
    func viewDidLoad()
    func didSelectItemAt()
}

class DeliveryPresenter: DeliveryPresenterProtocol {
    // MARK: Dependencies
    
    weak private var view: DeliveryViewController?
    private var coordinator: AppCoordinator?
    private var service: DeliveryService?
    
    // MARK: Init
    init(coordinator: AppCoordinator, view: DeliveryViewController, service: DeliveryService) {
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
    
    func didSelectItemAt() {
        showOnboarding()
    }
    
    // MARK: Navigation
    
    private func showOnboarding() {
        coordinator?.moveToOnboarding()
    }
}

//
//  DeliveryPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import Foundation

protocol DeliveryPresenterProtocol {
    func didSelectItemAt()
}

class DeliveryPresenter: DeliveryPresenterProtocol {
    // MARK: Dependencies
    
    weak private var view: DeliveryViewController?
    private var coordinator: AppCoordinator?
    
    // MARK: Init
    init(coordinator: AppCoordinator, view: DeliveryViewController) {
        self.coordinator = coordinator
        self.view = view
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

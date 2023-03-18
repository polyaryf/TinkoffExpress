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
    weak private var view: DeliveryViewController?
    private var coordinator: AppCoordinator?
    
    // Initialization
    init(coordinator: AppCoordinator, view: DeliveryViewController) {
        self.coordinator = coordinator
        self.view = view
    }
}


// MARK: - Event
extension DeliveryPresenter {
    func didSelectItemAt() {
        showOnboarding()
    }
}


// MARK: - Navigation
extension DeliveryPresenter {
    private func showOnboarding() {
        coordinator?.moveToOnboarding()
    }
}

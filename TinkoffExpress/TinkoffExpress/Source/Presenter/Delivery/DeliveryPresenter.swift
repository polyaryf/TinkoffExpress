//
//  DeliveryPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import Foundation

protocol DeliveryPresenterProtocol {
    func showOnboarding()
}

class DeliveryPresenter {
    weak private var view: DeliveryViewController?
    private var coordinator: AppCoordinator?
    
    // Initialization
    init(coordinator: AppCoordinator, view: DeliveryViewController) {
        self.coordinator = coordinator
        self.view = view
    }
}

// MARK: - Navigation
extension DeliveryPresenter: DeliveryPresenterProtocol {
    func showOnboarding() {
        coordinator?.moveToOnboarding()
    }
}

//
//  OnboardingPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import Foundation

protocol OnboardingPresenterProtocol {
    func checkoutButtonTapped()
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    weak private var view: OnboardingViewController?
    private var coordinator: AppCoordinator?

    // Initialization
    init(coordinator: AppCoordinator, view: OnboardingViewController) {
        self.coordinator = coordinator
        self.view = view
    }
}


// MARK: - Event
extension OnboardingPresenter {
    func checkoutButtonTapped() {
        showDestination()
    }
}


// MARK: - Navigation
extension OnboardingPresenter {
    private func showDestination() {
        coordinator?.moveToDestination()
    }
}

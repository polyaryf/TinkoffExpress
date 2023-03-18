//
//  OnboardingPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import Foundation

protocol OnboardingPresenterProtocol {
    func showDestination()
}

class OnboardingPresenter {
    weak private var view: OnboardingViewController?
    private var coordinator: AppCoordinator?

    // Initialization
    init(coordinator: AppCoordinator, view: OnboardingViewController) {
        self.coordinator = coordinator
        self.view = view
    }
}

// MARK: - Navigation
extension OnboardingPresenter: OnboardingPresenterProtocol {
    func showDestination() {
        coordinator?.moveToDestination()
    }
}

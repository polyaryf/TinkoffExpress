//
//  OnboardingPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import Foundation

protocol OnboardingPresenterProtocol {
    func continueButtonTapped()
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    // MARK: Dependencies

    weak private var view: OnboardingViewController?
    private var coordinator: AppCoordinator?

    // MARK: Init
    init(coordinator: AppCoordinator, view: OnboardingViewController) {
        self.coordinator = coordinator
        self.view = view
    }
    
    // MARK: Events
    
    func continueButtonTapped() {
        showDestination()
    }
    
    // MARK: Navigation
    
    private func showDestination() {
        coordinator?.moveToDestination()
    }
}

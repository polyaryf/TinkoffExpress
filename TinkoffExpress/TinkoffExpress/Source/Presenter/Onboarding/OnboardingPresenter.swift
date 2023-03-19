//
//  OnboardingPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import Foundation

protocol OnboardingPresenterProtocol {
    func viewDidLoad()
    func continueButtonTapped()
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    // MARK: Dependencies

    weak private var view: OnboardingViewController?
    private var coordinator: AppCoordinator?
    private var service: OnboardingService?

    // MARK: Init
    init(coordinator: AppCoordinator, view: OnboardingViewController, service: OnboardingService) {
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
    
    func continueButtonTapped() {
        showDestination()
    }
    
    // MARK: Navigation
    
    private func showDestination() {
        coordinator?.moveToDestination()
    }
}

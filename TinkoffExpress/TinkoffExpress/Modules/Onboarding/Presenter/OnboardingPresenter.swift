//
//  DeliveryPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

protocol OnboardingPresenterProtocol {
    func viewDidLoad()
    func continueButtonTapped()
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    // MARK: Dependencies

    weak var view: OnboardingViewController?
    private let service: OnboardingService
    private let router: IOnboardingRouter

    // MARK: Init
    
    init(
        service: OnboardingService,
        router: IOnboardingRouter
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
    
    func continueButtonTapped() {
        showMeetingAppointment()
    }
    
    // MARK: Navigation
    
    private func showMeetingAppointment() {
        router.openMeetingAppointment()
    }
}

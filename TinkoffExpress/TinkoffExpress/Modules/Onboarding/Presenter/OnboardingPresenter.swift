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
    private var coordinator: Coordinator?
    private var service: OnboardingService?

    // MARK: Init
    init(coordinator: Coordinator, service: OnboardingService) {
        self.coordinator = coordinator
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
        showMeetingAppointment()
    }
    
    // MARK: Navigation
    
    private func showMeetingAppointment() {
        coordinator?.move(MeetingAppointmentAssembly(), with: .push)
    }
}

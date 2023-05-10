//
//  OnboardingAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

protocol IOnboardingAssembly {
    func createOnboardingView() -> UIViewController
}

final class OnboardingAssembly: IOnboardingAssembly {
    func createOnboardingView() -> UIViewController {
        let mockService = MockOnboardingService()
        let router = OnboardingRouter(meetingAppointmentAssembly: MeetingAppointmentAssembly())
        let presenter = OnboardingPresenter(service: mockService, router: router)
        let viewController = OnboardingViewController(onboardingPresenter: presenter)
        presenter.view = viewController
        router.transitionHandler = viewController
        return viewController
    }
}

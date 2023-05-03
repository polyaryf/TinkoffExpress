//
//  MeetingAppointmentAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 03.04.2023.
//

import UIKit

final class MeetingAppointmentAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let mockService = MockMeetingAppointmentService()
        let router = MeetingAppointmentRouter(
            addressInputAssembly: AddressInputAssembly(),
            abTestAssembly: ABTestAssembly()
        )

        let presenter = MeetingAppointmentPresenter(
            router: router,
            service: mockService
        )

        let viewController = MeetingAppointmentViewController(meetingAppointmentPresenter: presenter)
        presenter.view = viewController
        router.transitionHandler = viewController
        return viewController
    }
}

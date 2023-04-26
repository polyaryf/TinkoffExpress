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
        let presenter = MeetingAppointmentPresenter(coordinator: coordinator, service: mockService)
        let viewController = MeetingAppointmentViewController(meetingAppointmentPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

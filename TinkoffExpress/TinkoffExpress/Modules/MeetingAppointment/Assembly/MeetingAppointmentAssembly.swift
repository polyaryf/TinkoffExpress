//
//  MeetingAppointmentAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 03.04.2023.
//

import UIKit

protocol IMeetingAppointmentAssembly {
    func createMeetingAppointmentView() -> UIViewController
    func createMeetingAppointmentView(with model: TEApiOrder) -> UIViewController
}

final class MeetingAppointmentAssembly: IMeetingAppointmentAssembly {
    func createMeetingAppointmentView(with model: TEApiOrder) -> UIViewController {
        let mockService = MeetingAppointmentService(api: TEApiService())
        let router = MeetingAppointmentRouter(
            addressInputAssembly: AddressInputAssembly(),
            abTestAssembly: ABTestAssembly(),
            orderCheckoutAssembly: OrderCheckoutAssembly()
        )

        let presenter = MeetingAppointmentPresenter(
            router: router,
            service: mockService,
            dateFormatter: TEDateFormatter(),
            addressSearchType: .daData,
            useCase: .ordering,
            isCreatingOrder: false
        )

        let viewController = MeetingAppointmentViewController(presenter: presenter)
        presenter.view = viewController
        presenter.viewWillAppear(with: model)
        router.transitionHandler = viewController
        return viewController
    }
    
    func createMeetingAppointmentView() -> UIViewController {
        let mockService = MeetingAppointmentService(api: TEApiService())
        let router = MeetingAppointmentRouter(
            addressInputAssembly: AddressInputAssembly(),
            abTestAssembly: ABTestAssembly(),
            orderCheckoutAssembly: OrderCheckoutAssembly()
        )

        let presenter = MeetingAppointmentPresenter(
            router: router,
            service: mockService,
            dateFormatter: TEDateFormatter(),
            addressSearchType: .daData,
            useCase: .ordering,
            isCreatingOrder: true
        )

        let viewController = MeetingAppointmentViewController(presenter: presenter)
        presenter.view = viewController
        router.transitionHandler = viewController
        return viewController
    }
}

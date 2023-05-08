//
//  MeetingAppointmentAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 03.04.2023.
//

import UIKit

final class MeetingAppointmentAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let mockService = MeetingAppointmentService(api: TEApiService())
        let router = MeetingAppointmentRouter(
            addressInputAssembly: AddressInputAssembly(),
            abTestAssembly: ABTestAssembly(),
            orderCheckoutAssembly: OrderCheckoutAssembly()
        )

        let presenter = MeetingAppointmentPresenter(
            router: router,
            service: mockService,
            addressSearchType: .daData,
            useCase: .ordering
        )

        let viewController = MeetingAppointmentViewController(presenter: presenter)
        presenter.view = viewController
        router.transitionHandler = viewController
        return viewController
    }
}

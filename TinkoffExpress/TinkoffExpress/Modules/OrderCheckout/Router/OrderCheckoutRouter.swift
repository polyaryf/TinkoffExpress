//
//  OrderCheckoutRouter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 06.05.2023.
//

import UIKit

protocol IOrderCheckoutRouter {
    func openFinalDelivery(with model: FinalDelivery)
    func openMeetingAppointment(with model: TEApiOrder)
}

final class OrderCheckoutRouter: IOrderCheckoutRouter {
    // MARK: Dependencies

    weak var transitionHandler: UIViewController?
    private let finalDeliveryAssembly: IFinalDelivaryAssembly
    private let meetingAppointmentAssembly: IMeetingAppointmentAssembly
    
    // MARK: Init
    
    init(
        finalDeliveryAssembly: IFinalDelivaryAssembly,
        meetingAppointmentAssembly: IMeetingAppointmentAssembly
    ) {
        self.finalDeliveryAssembly = finalDeliveryAssembly
        self.meetingAppointmentAssembly = meetingAppointmentAssembly
    }
    
    // MARK: IOrderCheckoutRouter
    
    func openFinalDelivery(with model: FinalDelivery) {
        let finalDeliveryView = finalDeliveryAssembly.createFinalDeliveryView(with: model)
        transitionHandler?.navigationController?.setViewControllers([finalDeliveryView], animated: true)
    }
    
    func openMeetingAppointment(with model: TEApiOrder) {
        let meetingAppointmentView = meetingAppointmentAssembly.createMeetingAppointmentView()
        transitionHandler?.navigationController?.pushViewController(meetingAppointmentView, animated: true)
    }
}

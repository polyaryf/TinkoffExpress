//
//  OnboardingRouter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.05.2023.
//

import UIKit

protocol IOnboardingRouter {
    func openMeetingAppointment()
}

final class OnboardingRouter: IOnboardingRouter {
    // MARK: Dependencies
   
    weak var transitionHandler: UIViewController?
    private let meetingAppointmentAssembly: IMeetingAppointmentAssembly
    
    init(meetingAppointmentAssembly: IMeetingAppointmentAssembly) {
        self.meetingAppointmentAssembly = meetingAppointmentAssembly
    }
    
    // MARK: IOnboardingRouter
    
    func openMeetingAppointment() {
        let meetingAppointmentView = meetingAppointmentAssembly.createMeetingAppointmentView()
        transitionHandler?.navigationController?.pushViewController(meetingAppointmentView, animated: true)
    }
}

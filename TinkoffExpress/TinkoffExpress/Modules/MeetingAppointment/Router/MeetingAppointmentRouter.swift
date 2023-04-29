//
//  MeetingAppointmentRouter.swift
//  TinkoffExpress
//
//  Created by r.akhmadeev on 29.04.2023.
//

import UIKit

protocol IMeetingAppointmentRouter {
    func openAddressInput(output: IAddressInputModuleOutput)
}

final class MeetingAppointmentRouter: IMeetingAppointmentRouter {
    // MARK: Dependencies

    weak var transitionHandler: UIViewController?
    private let addressInputAssembly: IAddressInputAssembly

    // MARK: Init

    init(addressInputAssembly: IAddressInputAssembly) {
        self.addressInputAssembly = addressInputAssembly
    }

    // MARK: IMeetingAppointmentRouter

    func openAddressInput(output: IAddressInputModuleOutput) {
        let addressInputView = addressInputAssembly.createAddressInputView(output: output)
        let navigationController = UINavigationController(rootViewController: addressInputView)
        transitionHandler?.present(navigationController, animated: true)
    }
}

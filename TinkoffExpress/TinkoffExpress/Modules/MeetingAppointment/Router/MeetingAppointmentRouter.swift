//
//  MeetingAppointmentRouter.swift
//  TinkoffExpress
//
//  Created by r.akhmadeev on 29.04.2023.
//

import UIKit

protocol IMeetingAppointmentRouter {
    func openAddressInput(output: IAddressInputModuleOutput)
    func openABtest(output: IABTestModuleOutput)
}

final class MeetingAppointmentRouter: IMeetingAppointmentRouter {
    // MARK: Dependencies

    weak var transitionHandler: UIViewController?
    private let addressInputAssembly: IAddressInputAssembly
    private let abTestAssembly: IABTestAssembly

    // MARK: Init

    init(
        addressInputAssembly: IAddressInputAssembly,
        abTestAssembly: IABTestAssembly
    ) {
        self.addressInputAssembly = addressInputAssembly
        self.abTestAssembly = abTestAssembly
    }

    // MARK: IMeetingAppointmentRouter

    func openAddressInput(output: IAddressInputModuleOutput) {
        let addressInputView = addressInputAssembly.createAddressInputView(output: output)
        let navigationController = UINavigationController(rootViewController: addressInputView)
        transitionHandler?.present(navigationController, animated: true)
    }
    
    func openABtest(output: IABTestModuleOutput) {
        let abTestView = abTestAssembly.createABTestView(output: output)
        let navigationController = UINavigationController(rootViewController: abTestView)
        transitionHandler?.present(navigationController, animated: true)
    }
}

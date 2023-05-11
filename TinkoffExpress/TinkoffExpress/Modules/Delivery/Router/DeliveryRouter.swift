//
//  DeliveryRouter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.05.2023.
//

import UIKit

protocol IDeliveryRouter {
    func openOnboarding()
}

final class DeliveryRouter: IDeliveryRouter {
    // MARK: Dependencies
   
    weak var transitionHandler: UIViewController?
    private let onboardingAssembly: IOnboardingAssembly
    
    // MARK: Init
    
    init(onboardingAssembly: IOnboardingAssembly) {
        self.onboardingAssembly = onboardingAssembly
    }
    
    // MARK: IDeliveryRouter
    
    func openOnboarding() {
        let onboardingView = onboardingAssembly.createOnboardingView()
        transitionHandler?.navigationController?.pushViewController(onboardingView, animated: true)
    }
}

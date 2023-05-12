//
//  OnboardingPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import Foundation

protocol OnboardingService {
    func loadItems(completion: @escaping ([Onboarding]?) -> Void)
}

final class MockOnboardingService: OnboardingService {
    func loadItems(completion: @escaping ([Onboarding]?) -> Void) {
        let items: [Onboarding] = [
            .init(text: NSLocalizedString("onboardingPin", comment: ""), imageName: "OnboardingPin"),
            .init(text: NSLocalizedString("onboardingMessage", comment: ""), imageName: "OnboardingMessage"),
            .init(text: NSLocalizedString("onboardingLetter", comment: ""), imageName: "OnboardingLetter")
        ]
        completion(items)
    }
}

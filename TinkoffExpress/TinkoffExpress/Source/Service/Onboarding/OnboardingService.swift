//
//  OnboardingService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 19.03.2023.
//

import Foundation

protocol OnboardingService {
    func loadItems(completion: @escaping ([Onboarding]?) -> Void)
}

class MockOnboardingService: OnboardingService {
    func loadItems(completion: @escaping ([Onboarding]?) -> Void) {
        let items: [Onboarding] = [
            .init(text: "Выберите, когда и куда доставить", imageName: "OnboardingPin"),
            .init(text: "В назначенный день мы свяжемся с вами", imageName: "OnboardingMessage"),
            .init(text: "Курьер доставит посылку в указанное время", imageName: "OnboardingLetter")
        ]
        completion(items)
    }
}

//
//  SettingsService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 06.05.2023.
//

import Foundation
import Combine

protocol ISettingsService {
    var currentTogglePublisher: AnyPublisher<Bool, Never> { get }
    
    func getIsToggled() -> Bool
    func setToggle(with flag: Bool)
}

final class SettingsService: ISettingsService {
    static let shared = SettingsService()
    
    var currentTogglePublisher: AnyPublisher<Bool, Never> {
        isToggled.eraseToAnyPublisher()
    }
    
    private var isToggled: CurrentValueSubject<Bool, Never> = .init(true)
    
    func getIsToggled() -> Bool {
        isToggled.value
    }
    
    func setToggle(with flag: Bool) {
        isToggled.value = flag
    }
}

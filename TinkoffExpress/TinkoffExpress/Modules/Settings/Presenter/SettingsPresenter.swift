//
//  SettingsPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 06.05.2023.
//

import Foundation

protocol SettingsPresenterProtocol {
    func viewToggleSwitchDidChange(with flag: Bool)
}

final class SettingsPresenter: SettingsPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: SettingsViewController?
    private let service: ISettingsService
    
    // MARK: Init
    
    init(service: SettingsService) {
        self.service = service
    }
    
    // MARK: SettingsPresenterProtocol

    func viewToggleSwitchDidChange(with flag: Bool) {
        service.setToggle(with: flag)
    }
}

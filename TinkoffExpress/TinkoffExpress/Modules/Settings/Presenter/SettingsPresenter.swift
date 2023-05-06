//
//  SettingsPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 06.05.2023.
//

import Foundation

protocol SettingsPresenterProtocol {
    func viewDidLoad()
}

final class SettingsPresenter: SettingsPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: SettingsViewController?
    private var coordinator: Coordinator?
    private var service: SettingsService?
    
    // MARK: Init
    init(coordinator: Coordinator, service: SettingsService) {
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        service?.loadItems { [weak self] items in
            guard let self = self else { return }
            self.view?.items = items ?? []
        }
    }
}

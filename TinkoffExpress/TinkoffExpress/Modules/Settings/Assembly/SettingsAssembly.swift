//
//  SettingsAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 06.05.2023.
//

import UIKit

final class SettingsAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let presenter = SettingsPresenter(service: SettingsService.shared)
        let viewController = SettingsViewController(settingsPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

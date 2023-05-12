//
//  SettingsAssembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 06.05.2023.
//

import UIKit

protocol ISettingsAssembly {
    func createSettingsView() -> UIViewController
}

final class SettingsAssembly: ISettingsAssembly {
    func createSettingsView() -> UIViewController {
        let presenter = SettingsPresenter(service: SettingsService.shared)
        let viewController = SettingsViewController(settingsPresenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

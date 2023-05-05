//
//  FinalDeliveryAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

final class FinalDeliveryAssembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let presenter = FinalDeliveryPresenter()
        let viewController = FinalDeliveryViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

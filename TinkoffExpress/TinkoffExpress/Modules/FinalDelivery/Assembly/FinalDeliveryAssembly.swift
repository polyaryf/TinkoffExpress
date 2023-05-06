//
//  FinalDeliveryAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol IFinalDelivaryAssembly {
    func createFinalDeliveryView(with model: FinalDelivery) -> UIViewController
}

final class FinalDeliveryAssembly: IFinalDelivaryAssembly {
    func createFinalDeliveryView(with model: FinalDelivery) -> UIViewController {
        let presenter = FinalDeliveryPresenter()
        let viewController = FinalDeliveryViewController(item: model, presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

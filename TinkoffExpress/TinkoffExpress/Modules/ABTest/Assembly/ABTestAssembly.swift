//
//  ABTestAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 30.04.2023.
//

import UIKit

protocol IABTestAssembly {
    func createABTestView() -> UIViewController
}

final class ABTestAssembly: IABTestAssembly {
    func createABTestView() -> UIViewController {
        let presenter = ABTestPresenter()
        let view = ABTestViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}



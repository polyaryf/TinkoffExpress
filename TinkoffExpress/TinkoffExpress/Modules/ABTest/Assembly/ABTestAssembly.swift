//
//  ABTestAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 30.04.2023.
//

import UIKit

protocol IABTestAssembly {
    func createABTestView(output: IABTestModuleOutput) -> UIViewController
}

final class ABTestAssembly: IABTestAssembly {
    func createABTestView(output: IABTestModuleOutput) -> UIViewController {
        let networkService = DaDataApiService()
        let service = RestABTestService(networkService: networkService)
        let helper = ABTestHelper()
        let presenter = ABTestPresenter(service: service, output: output, helper: helper)
        let view = ABTestViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}



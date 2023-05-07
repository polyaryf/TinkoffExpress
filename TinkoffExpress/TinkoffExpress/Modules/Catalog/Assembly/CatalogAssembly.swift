//
//  CatalogAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.05.2023.
//

import UIKit

protocol ICatalogAssembly {
    func createCatalogView() -> UIViewController
}

final class CatalogAssembly: ICatalogAssembly {
    func createCatalogView() -> UIViewController {
        let mockService = MockCatalogService()
        let presenter = CatalogPresenter(service: mockService)
        let view = CatalogViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}

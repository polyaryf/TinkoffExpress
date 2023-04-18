//
//  AddressInputAsembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 17.04.2023.
//

import UIKit

final class AddressInputAsembly: Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController {
        let mockService = MockAddressInputService()
        let restservice = RestAddressInputService(networkService: DaDataApiService(), mapper: AddressInputMapper())
        let presenter = AddressInputPresenter(coordinator: coordinator, service: mockService)
        let viewController = AddressInputViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

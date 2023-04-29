//
//  AddressInputAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 17.04.2023.
//

import UIKit

protocol IAddressInputAssembly {
    func createAddressInputView() -> UIViewController
}

final class AddressInputAssembly: IAddressInputAssembly {
    func createAddressInputView() -> UIViewController {
        let mockService = MockAddressInputService()

        let restService = RestAddressInputService(
            networkService: DaDataApiService(),
            mapper: AddressInputMapper()
        )

        let presenter = AddressInputPresenter(service: mockService)
        let viewController = AddressInputViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

//
//  AddressInputPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 15.04.2023.
//

import Foundation

protocol AddressInputPresenterProtocol {
    func viewDidLoad(input text: String)
    func doneButtonTapped()
    func cancelButtonTapped()
}

class AddressInputPresenter: AddressInputPresenterProtocol {
    // MARK: Dependencies
        
    weak var view: AddressInputViewControllerProtocol?
    private let coordinator: Coordinator
    private let service: AddressInputService
    
    // MARK: Init
    
    init(coordinator: Coordinator, service: AddressInputService) {
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad(input text: String) {
        service.loadAddresses(with: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let addresses):
                view?.showAddresses(addresses: addresses)
            case .failure:
                view?.showErrorLabel()
            }
        }
    }
    
    func doneButtonTapped() {}
    
    func cancelButtonTapped() {}
}

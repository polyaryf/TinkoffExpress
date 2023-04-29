//
//  AddressInputPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 15.04.2023.
//

import Foundation

protocol AddressInputPresenterProtocol {
    func viewDidChangeText(input text: String)
    func doneButtonTapped()
    func cancelButtonTapped()
}

class AddressInputPresenter: AddressInputPresenterProtocol {
    // MARK: Dependencies
        
    weak var view: AddressInputViewControllerProtocol?
    private let service: AddressInputService
    
    var timer: Timer?
    
    // MARK: Init
    
    init(service: AddressInputService) {
        self.service = service
    }
    
    func viewDidChangeText(input text: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: 0.5,
            repeats: false,
            block: { [weak self] _ in
                self?.service.loadAddresses(with: text) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let addresses):
                        self.view?.showAddresses(addresses: addresses)
                    case .failure:
                        self.view?.showErrorLabel()
                    }
                }
            }
        )
    }
    
    func doneButtonTapped() {}
    
    func cancelButtonTapped() {
        view?.closeView()
    }
}

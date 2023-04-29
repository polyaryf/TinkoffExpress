//
//  AddressInputPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 15.04.2023.
//

import Foundation

protocol IAddressInputModuleOutput: AnyObject {
    func addressInputModule(didCompleteWith addressInput: String)
}

protocol AddressInputPresenterProtocol {
    func viewDidChangeText(input text: String)
    func doneButtonTapped()
    func cancelButtonTapped()
}

class AddressInputPresenter: AddressInputPresenterProtocol {
    // MARK: Dependencies
        
    weak var view: AddressInputViewControllerProtocol?
    private weak var output: IAddressInputModuleOutput?
    private let service: AddressInputService

    // MARK: State

    private var timer: Timer?
    private var inputText = ""

    // MARK: Init
    
    init(service: AddressInputService, output: IAddressInputModuleOutput) {
        self.service = service
        self.output = output
    }

    // MARK: AddressInputPresenterProtocol

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
    
    func doneButtonTapped() {
        output?.addressInputModule(didCompleteWith: inputText)
        view?.closeView()
    }
    
    func cancelButtonTapped() {
        view?.closeView()
    }
}

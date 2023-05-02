//
//  ABTestPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 30.04.2023.
//

import UIKit

protocol IABTestModuleOutput: AnyObject {
    func abTestModule(didCompleteWith addressInput: String)
}

protocol ABTestPresenterProtocol {
    func cancelButtonTapped()
    func doneButtonTapped(with address: ABInputAddress?)
}

class ABTestPresenter: ABTestPresenterProtocol {
    // MARK: Dependencies
        
    weak var view: ABTestViewControllerProtocol?
    private weak var output: IABTestModuleOutput?
    private let service: ABTestService
    private let helper: ABTestHelper
    
    // MARK: Init
    
    init(
        service: ABTestService,
        output: IABTestModuleOutput,
        helper: ABTestHelper
    ) {
        self.service = service
        self.output = output
        self.helper = helper
    }
    
    private func viewWillDisappear(input abAddress: ABInputAddress) {
        let text = helper.toString(from: abAddress)
        self.service.loadAddress(with: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let address):
                self.output?.abTestModule(didCompleteWith: address)
            case .failure:
                break
            }
        }
    }
    
    // MARK: ABTestPresenterProtocol
    
    func cancelButtonTapped() {
        view?.closeABTestView()
    }
    
    func doneButtonTapped(with address: ABInputAddress?) {
        guard let address else { return }
        viewWillDisappear(input: address)
        view?.closeABTestView()
    }
}

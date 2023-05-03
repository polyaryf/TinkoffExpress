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
    
    // MARK: Init
    
    init(
        service: ABTestService,
        output: IABTestModuleOutput
    ) {
        self.service = service
        self.output = output
    }
    
    // MARK: ABTestPresenterProtocol
    
    func cancelButtonTapped() {
        view?.closeABTestView()
    }
    
    func doneButtonTapped(with address: ABInputAddress?) {
        guard let address else { return }
        let text = address.stringRepresentation
        output?.abTestModule(didCompleteWith: text)
        view?.closeABTestView()
    }
}

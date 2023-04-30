//
//  ABTestPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 30.04.2023.
//

import UIKit

protocol ABTestPresenterProtocol {
    func cancelButtonTapped()
    func doneButtonTapped()
}

class ABTestPresenter: ABTestPresenterProtocol {
    // MARK: Dependencies
        
    weak var view: ABTestViewControllerProtocol?
    
    // MARK: ABTestPresenterProtocol
    
    func cancelButtonTapped() {
        view?.closeABTestView()
    }
    
    func doneButtonTapped() {
        view?.closeABTestView()
    }
}

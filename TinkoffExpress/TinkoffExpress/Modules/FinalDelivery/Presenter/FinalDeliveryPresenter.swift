//
//  FinalDeliveryPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol FinalDeliveryPresenterProtocol {
    func viewDidLoad()
    func okButtonTapped()
}

class FinalDeliveryPresenter: FinalDeliveryPresenterProtocol {
    // MARK: Dependency
    
    weak var view: IFinalDeliveryViewController?
    
    // MARK: FinalDeliveryPresenterProtocol
    
    func viewDidLoad() {}
    
    func okButtonTapped() {
        view?.closeView()
    }
}

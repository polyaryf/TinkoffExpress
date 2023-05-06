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
    
    // MARK: State
    
    private let item: FinalDelivery
    
    // MARK: Init
    
    init(item: FinalDelivery) {
        self.item = item
    }
    
    // MARK: FinalDeliveryPresenterProtocol
    
    func viewDidLoad() {
        view?.setItem(with: item)
    }
    
    func okButtonTapped() {
        view?.closeView()
    }
}

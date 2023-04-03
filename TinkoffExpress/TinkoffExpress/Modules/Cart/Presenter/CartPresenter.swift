//
//  CartPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

protocol CartPresenterProtocol {
    func viewDidLoad()
    func checkoutButtonTapped()
    func checkoutButtonTouchDown(with button: UIButton)
    func checkoutButtonTouchUpInside(with button: UIButton)
}

final class CartPresenter: CartPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: CartViewController?
    private var coordinator: Coordinator?
    private var service: CartService?

    // MARK: Init
    init(coordinator: Coordinator, service: CartService) {
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        service?.loadItems { [weak self] items in
            guard let self = self else { return }
            self.view?.items = items ?? []
        }
    }
    
    // MARK: Events
    
    func checkoutButtonTapped() {
        showDelivery()
    }
    
    func checkoutButtonTouchDown(with button: UIButton) {
        button.backgroundColor = UIColor(named: "yellowButtonPressedColor")
    }
    
    func checkoutButtonTouchUpInside(with button: UIButton) {
        button.backgroundColor = UIColor(named: "yellowButtonColor")
    }
    
    // MARK: Navigation
    
    private func showDelivery() {
        coordinator?.move(DeliveryAssembly(), with: .present)
    }
}

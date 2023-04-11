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
    private let coordinator: Coordinator
    private let service: CartService
    
    // MARK: Init
    init(coordinator: Coordinator, service: CartService) {
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        service.loadItems { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let carts):
                self.view?.showItems(items: carts)
            case .failure:
                // TODO: добавить обработку ошибки UI-элементом
//               self.view.showError()
                break
            }
        }
    }
    
    // MARK: Events
    
    func checkoutButtonTapped() {
        showDelivery()
    }
    
    // TODO: убрать эту покраску кнопки из presenter
    // можно воспользоваться нашей готовой кнопкой
    /// просто добавить в конфиг нужный размер, краситься она там сама будет
    func checkoutButtonTouchDown(with button: UIButton) {
        button.backgroundColor = UIColor(named: "yellowButtonPressedColor")
    }
    
    func checkoutButtonTouchUpInside(with button: UIButton) {
        button.backgroundColor = UIColor(named: "yellowButtonColor")
    }
    
    // MARK: Navigation
    
    private func showDelivery() {
        coordinator.move(DeliveryAssembly(), with: .present)
    }
}

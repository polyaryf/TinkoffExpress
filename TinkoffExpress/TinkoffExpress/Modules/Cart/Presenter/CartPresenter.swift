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
    private let service: ICartService
    
    private var products: [CartProduct] = []

    // MARK: Init
    
    init(service: ICartService) {
        self.service = service
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        products = service.getAll()
        view?.setItems(with: products.map { cartProduct in
            Cart(text: cartProduct.product.title, imageName: cartProduct.product.image, count: "\(cartProduct.counter)")
        })
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
//        coordinator?.move(DeliveryAssembly(), with: .present)
    }
}

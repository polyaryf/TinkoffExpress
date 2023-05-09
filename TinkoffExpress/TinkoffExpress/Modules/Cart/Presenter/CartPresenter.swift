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
            CartItem(
                text: cartProduct.product.title,
                imageName: cartProduct.product.image,
                count: "\(cartProduct.counter)"
            )
        })
    }
    
    // MARK: Events
    
    func checkoutButtonTapped() {
        showDelivery()
    }
    
    // MARK: Navigation
    
    private func showDelivery() {}
}

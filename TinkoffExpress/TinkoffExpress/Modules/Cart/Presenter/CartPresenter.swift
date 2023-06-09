//
//  CartPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit
import Combine

protocol CartPresenterProtocol {
    func viewDidLoad()
    func checkoutButtonTapped()
    func viewDidIncreaseCounterOfItem(at index: Int)
    func viewDidDecreaseCounterOfItem(at index: Int)
    func deleteAllItems()
}

final class CartPresenter: CartPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: ICartViewController?
    private let service: ICartService
    private let router: ICartRouter
    
    private var cartProducts: [CartProduct] = []
    var cancellables: Set<AnyCancellable> = []

    // MARK: Init
    
    init(
        service: ICartService,
        router: ICartRouter
    ) {
        self.service = service
        self.router = router
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        service.currentProductsPublisher.receive(on: DispatchQueue.main)
            .sink { [weak self] cartProducts in
                guard let self else { return }
                
                self.cartProducts = cartProducts.map {
                    CartProduct(product: $0.product, counter: $0.counter)
                }
                
                self.view?.setItems(with: self.cartProducts.map { cartProduct in
                    CartItem(
                        text: cartProduct.product.title,
                        imageName: cartProduct.product.image,
                        count: "\(cartProduct.counter)",
                        price: "\(cartProduct.product.price)"
                    )
                })
            }
            .store(in: &cancellables)
    }
    
    func viewDidIncreaseCounterOfItem(at index: Int) {
        service.add(product: cartProducts[index].product)
    }
    
    func viewDidDecreaseCounterOfItem(at index: Int) {
        service.remove(product: cartProducts[index].product)
    }
    
    func deleteAllItems() {
        service.removeAllProducts()
        view?.setItems(with: [])
    }
    
    // MARK: Events
    
    func checkoutButtonTapped() {
        if cartProducts.isEmpty {
            return
        } else {
            var items: [TEApiItem] = []
            for cartProduct in cartProducts {
                for _ in 0..<cartProduct.counter {
                    items.append(TEApiItem(name: cartProduct.product.title, price: cartProduct.product.price))
                }
            }
            router.openDelivery()
            // TODO: move to Delivery with [item]
        }
    }
}

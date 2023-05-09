//
//  CartService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import Foundation
import Combine

protocol ICartService {
    var currentProductsPublisher: AnyPublisher<[CartProduct], Never> { get }
    
    func getAll() -> [CartProduct]
    func add(product: Product)
    func remove(product: Product)
    func removeAllProducts()
}

final class CartService: ICartService {
    static let shared = CartService()
    
    var currentProductsPublisher: AnyPublisher<[CartProduct], Never> {
        products.eraseToAnyPublisher()
    }
    
    private var products: CurrentValueSubject<[CartProduct], Never> = .init([])
    
    private init() {}
    
    func getAll() -> [CartProduct] {
        products.value
    }
    
    func add(product: Product) {
        let cartProducts = products.value
        if !cartProducts.contains(where: { cartProduct in
            cartProduct.product == product
        }) {
            products.value.append(CartProduct(product: product, counter: 1))
            return
        }
        products.value = cartProducts.map { cartProduct in
            if cartProduct.product == product {
                return CartProduct(product: cartProduct.product, counter: cartProduct.counter + 1)
            }
            return cartProduct
        }
    }
    
    func remove(product: Product) {
        products.value = products.value
        .map { cartProduct in
            if cartProduct.product == product {
                return CartProduct(product: cartProduct.product, counter: cartProduct.counter - 1)
            }
            return cartProduct
        }
        .filter {
            $0.counter > 0
        }
    }
    
    func removeAllProducts() {
        products.value.removeAll()
    }
}

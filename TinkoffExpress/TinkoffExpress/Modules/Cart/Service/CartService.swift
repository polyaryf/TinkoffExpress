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
        if !products.value.contains(where: { cartProduct in
            cartProduct.product == product
        }) {
            products.value.append(CartProduct(product: product, counter: 0))
        }
        products.value.forEach { cartProduct in
            if cartProduct.product == product {
                cartProduct.counter += 1
            }
        }
    }
    
    func remove(product: Product) {
        products.value.forEach { cartProduct in
            if cartProduct.product == product {
                if cartProduct.counter > 0 {
                    cartProduct.counter -= 1
                } else {
                    let id = products.value.firstIndex { $0 === cartProduct }
                    guard let id else { return }
                    products.value.remove(at: id)
                }
            }
        }
    }
    
    func removeAllProducts() {
        products.value.removeAll()
    }
}

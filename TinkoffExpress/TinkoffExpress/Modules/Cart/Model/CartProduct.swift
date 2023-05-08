//
//  CartProduct.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 08.05.2023.
//

import Foundation

class CartProduct {
    let product: Product
    var counter: Int
    
    init(product: Product, counter: Int) {
        self.product = product
        self.counter = counter
    }
}

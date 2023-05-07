//
//  Product.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.05.2023.
//

import Foundation

struct Product: Equatable {
    let productId: String = UUID().uuidString
    let productTypeId: String
    let title: String
    let price: Int
    let image: String
}

//
//  CatalogPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.05.2023.
//

import UIKit

protocol ICatalogPresenter {
    func viewDidLoad()
    func viewDidChangeCounterOfItem(at index: Int, counter: Int)
}

final class CatalogPresenter: ICatalogPresenter {
    // MARK: Dependencies
        
    weak var view: ICatalogViewController?
    private let service: CatalogService
    private let cartService: ICartService
    
    private var products: [CatalogProduct] = []
    
    // MARK: Init
    
    init(
        service: CatalogService,
        cartService: ICartService
    ) {
        self.service = service
        self.cartService = cartService
    }
    
    // MARK: ICatalogPresenter
    
    func viewDidLoad() {
        service.loadItems { [weak self] products in
            self?.products = products.map { product in
                return CatalogProduct(product: product, counter: 0)
            }
            self?.view?.setProducts(with: products)
        }
    }
    
    func viewDidChangeCounterOfItem(at index: Int, counter: Int) {
        if products[index].counter < counter {
            cartService.add(product: products[index].product)
        } else {
            cartService.remove(product: products[index].product)
        }
        products[index].counter = counter
    }
}

//
//  CatalogPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.05.2023.
//

import UIKit
import Combine

protocol ICatalogPresenter {
    func viewDidLoad()
    func viewDidIncreaseCounterOfItem(at index: Int)
    func viewDidDecreaseCounterOfItem(at index: Int)
}

final class CatalogPresenter: ICatalogPresenter {
    // MARK: Dependencies
        
    weak var view: ICatalogViewController?
    private let service: CatalogService
    private let cartService: ICartService
    
    private var catalogProducts: [CatalogProduct] = []
    var cancellables: Set<AnyCancellable> = []
    
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
            guard let self else { return }
            self.catalogProducts = products.map { product in
                return CatalogProduct(product: product, counter: 0)
            }
        }
        
        cartService.currentProductsPublisher.receive(on: DispatchQueue.main)
            .sink { [weak self] cartProducts in
                guard let self else { return }
                
                let newProducts = self.catalogProducts.map { catalogProduct in
                    if let cartProduct = cartProducts.first(where: { $0.product == catalogProduct.product }) {
                        return CatalogProduct(product: catalogProduct.product, counter: cartProduct.counter)
                    }
                    if !cartProducts.contains(where: {$0.product == catalogProduct.product}) {
                        return CatalogProduct(product: catalogProduct.product, counter: 0)
                    }
                    return catalogProduct
                }
                
                self.catalogProducts = newProducts
                self.view?.setProducts(with: self.catalogProducts)
            }
            .store(in: &cancellables)
    }
    
    func viewDidIncreaseCounterOfItem(at index: Int) {
        cartService.add(product: catalogProducts[index].product)
    }
    
    func viewDidDecreaseCounterOfItem(at index: Int) {
        cartService.remove(product: catalogProducts[index].product)
    }
}

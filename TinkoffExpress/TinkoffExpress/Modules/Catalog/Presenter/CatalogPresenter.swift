//
//  CatalogPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.05.2023.
//

import UIKit

protocol ICatalogPresenter {
    func viewDidLoad()
}

final class CatalogPresenter: ICatalogPresenter {
    // MARK: Dependencies
        
    weak var view: ICatalogViewController?
    private let service: CatalogService
    
    // MARK: Init
    
    init(service: CatalogService) {
        self.service = service
    }
    
    // MARK: ICatalogPresenter
    
    func viewDidLoad() {
        service.loadItems { [weak self] products in
            self?.view?.setProducts(with: products)
        }
    }
}

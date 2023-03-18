//
//  CartViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit
import SnapKit

final class CartViewController: UIViewController {
    // MARK: Dependencies
    
    private var cartPresenter: CartPresenterProtocol?
    
    // MARK: Subviews
    
    private lazy var checkoutButton = UIButton()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupCheckoutButton()
    }
    
    // MARK: Action
    
    @objc private func checkoutButtonTapped() {
        cartPresenter?.checkoutButtonTapped()
    }
    
    // MARK: Setup Dependencies
    
    func setPresenter(_ presenter: CartPresenterProtocol) {
        self.cartPresenter = presenter
    }
    
    // MARK: Setup Subviews
    
    private func setupCheckoutButton() {
        checkoutButton.setTitle("Оформить", for: .normal)
        checkoutButton.setTitleColor(.black, for: .normal)
        checkoutButton.layer.cornerRadius = 15
        checkoutButton.backgroundColor = .systemYellow
        
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        
        
        view.addSubview(checkoutButton)
        
        checkoutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
}

//
//  CartViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit
import SnapKit

final class CartViewController: UIViewController {
    private var cartPresenter: CartPresenterProtocol?
    
    private lazy var checkoutButton = UIButton()
}


// MARK: - Life Cycle
extension CartViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupCheckoutButton()
    }
}


// MARK: Action
extension CartViewController {
    @objc private func checkoutButtonTapped() {
        cartPresenter?.checkoutButtonTapped()
    }
}


// MARK: - Setup
extension CartViewController {
    private func setupCheckoutButton() {
        // Configure
        checkoutButton.setTitle("Оформить", for: .normal)
        checkoutButton.setTitleColor(.black, for: .normal)
        checkoutButton.layer.cornerRadius = 20
        checkoutButton.backgroundColor = .systemYellow
        
        // Add Target
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        
        // Add shadow
        checkoutButton.layer.shadowColor = UIColor.black.cgColor
        checkoutButton.layer.shadowOpacity = 0.2
        checkoutButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        checkoutButton.layer.shadowRadius = 4
        
        // Add Subview
        view.addSubview(checkoutButton)
        
        // Add Constraints
        checkoutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    func setPresenter(_ presenter: CartPresenterProtocol) {
        self.cartPresenter = presenter
    }
}

//
//  AddressInputViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 14.04.2023.
//

import UIKit

class AddressInputViewController: UIViewController {
    // MARK: Subviews
    private lazy var inputTextField: UITextField = {
        var textField: UITextField = .init()
        return textField
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Initial Configuration
    private func setupView() {
        navigationItem.largeTitleDisplayMode = .always
    }
}

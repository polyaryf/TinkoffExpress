//
//  ViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 16.03.2023.
//

import UIKit

class ViewController: UIViewController {
    private lazy var button: Button = {
        let config = Button.Configuration(
            title: "Loc.CommonSheet.PaymentForm.tinkoffPayPrimaryButton",
            image: UIImage(named: "cart"),
            style: .primaryTinkoff,
            contentSize: .basicLarge,
            imagePlacement: .trailing
        )

        let button = Button(configuration: config, action: { [weak self] in self?.actionClosure?() })
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

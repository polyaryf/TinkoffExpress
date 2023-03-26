//
//  OrderCheckoutViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit
import SnapKit

class OrderCheckoutViewController: UIViewController {
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        var table: UITableView = .init()
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private lazy var checkoutButton: Button = {
        let config = Button.Configuration(
            // TODO: add loc enum for strings
            title: "Оформить",
            style: .primaryTinkoff,
            contentSize: .basicLarge
        )
        // TODO: add action
        let button = Button(configuration: config, action: nil)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK: Initial Configuration
    
    private func setupView() {
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate
extension OrderCheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

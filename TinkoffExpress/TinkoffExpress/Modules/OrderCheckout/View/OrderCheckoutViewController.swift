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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Initial Configuration
    
    private func setupView() {
        view.backgroundColor = .white
        
        setupViewHierarchy()
        setupConstraints()
        setUpTable()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(88 + 28)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        checkoutButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setUpTable() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderCheckoutTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

// MARK: - UITableViewDelegate
extension OrderCheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderCheckoutTableViewCell()
        if indexPath.section == 0 {
            cell.setType(.whatWillBeDelivered)
        } else if indexPath.section == 1 {
            cell.setType(.delivery)
        } else {
            cell.setType(.payment)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
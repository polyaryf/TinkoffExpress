//
//  OrderCheckoutViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit
import SnapKit

final class OrderCheckoutViewController: UIViewController {
    // MARK: Dependencies
    
    private var orderCheckoutPresenter: OrderCheckoutPresenterProtocol
    

    // MARK: Properties
    
    // TODO: change model
    lazy var items: [OrderCheckout] = []
    
    // MARK: Subviews
    
    private lazy var navigationBar: UINavigationBar = .init()
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
        let button = Button(configuration: config) { [ weak self ] in
            guard let self else { return }
            self.checkoutButtonTapped()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Init
    
    init(orderCheckoutPresenter: OrderCheckoutPresenterProtocol) {
        self.orderCheckoutPresenter = orderCheckoutPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderCheckoutPresenter.viewDidLoad()

        setupView()
    }
    
    // MARK: Actions
    
    private func checkoutButtonTapped() {
        orderCheckoutPresenter.checkoutButtonTapped()
    }
    
    @objc private func backButtonTapped() {
        orderCheckoutPresenter.backButtonTapped()
    }
    
    // MARK: Initial Configuration
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor.orderCheckout")
        
        setupViewHierarchy()
        setupConstraints()
        setUpTable()
        setupNavBar()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
    }
    
    private func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(navigationBar.snp.bottom).offset(28)
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
        tableView.allowsSelection = false
        tableView.register(OrderCheckoutTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupNavBar() {
        let navItem = UINavigationItem(title: "Оформление товара")
        let backItem = UIBarButtonItem(
            image: UIImage(named: "arrow.back"),
            style: .plain,
            target: nil,
            action: #selector(backButtonTapped))
        navItem.leftBarButtonItem = backItem
        navigationBar.setItems([navItem], animated: false)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "backgroundColor.orderCheckout")
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "title.navBar.orderCheckout.color") ?? UIColor.black
        ]
        appearance.shadowColor = .clear
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}

// MARK: - UITableViewDelegate
extension OrderCheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderCheckoutTableViewCell()
        if indexPath.section == 0 {
            cell.setType(.whatWillBeDelivered)
            cell.setPrimaryText(items[0].whatWillBeDelivered)
        } else if indexPath.section == 1 {
            cell.setType(.delivery)
            cell.setPrimaryText(items[0].deliveryWhen)
            cell.setSecondaryText(items[0].deliveryWhere)
        } else {
            cell.setType(.payment)
            cell.setPrimaryText(items[0].paymentMethod)
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

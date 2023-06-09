//
//  OrderCheckoutViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit
import SnapKit

protocol IOrderCheckoutViewController: AnyObject {
    func startButtonLoading()
    func stopButtonLoading()
    func set(item: OrderCheckout)
    func showCancelAlert(with title: String)
    func showErrorAlert()
    func closeView()
}

final class OrderCheckoutViewController: UIViewController {
    // MARK: Dependencies
    
    private var orderCheckoutPresenter: OrderCheckoutPresenterProtocol
    
    // MARK: Properties
    
    private var item = OrderCheckout()
    
    // MARK: Subviews
    
    private lazy var tableView: UITableView = {
        var table: UITableView = .init()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private lazy var checkoutButton: Button = {
        var config = Button.Configuration()
        switch orderCheckoutPresenter.getModuleType() {
        case .creatingOrder:
            config = Button.Configuration(
                title: NSLocalizedString("orderCheckoutButton", comment: ""),
                style: .primaryTinkoff,
                contentSize: .basicLarge
            )
        case .editingOrder:
            config = Button.Configuration(
                title: NSLocalizedString("orderCheckoutCancelButton", comment: ""),
                style: .destructive,
                contentSize: .basicLarge
            )
        }
        
        let button = Button(configuration: config) { [weak self] in
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
        setupView()
        orderCheckoutPresenter.viewDidLoad()
    }
    
    // MARK: Actions
    
    private func checkoutButtonTapped() {
        orderCheckoutPresenter.checkoutButtonTapped()
    }
    
    @objc private func backButtonTapped() {
        orderCheckoutPresenter.backButtonTapped()
    }
    
    @objc func deliveryEditButtonTapped() {
        orderCheckoutPresenter.editButtonTapped()
    }
    
    @objc func paymentMethodEditButtonTapped() {
        showPaymentMethodAlert()
    }
    
    // MARK: Initial Configuration
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor.orderCheckout")
        
        setupViewHierarchy()
        setupConstraints()
        setUpTable()
        setupNavigationItem()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        checkoutButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setUpTable() {
        tableView.separatorStyle = .none
        tableView.delaysContentTouches = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(named: "backgroundColor.orderCheckout")
        tableView.register(OrderCheckoutTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupNavigationItem() {
        navigationItem.title = NSLocalizedString("orderCheckoutTitle", comment: "")
    }
    
    private func showPaymentMethodAlert() {
        let alert = UIAlertController(
            title: NSLocalizedString("orderCheckoutPaymentMethod", comment: ""),
            message: nil,
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(
            title: NSLocalizedString(TEApiPaymentMethod.card.localized, comment: ""),
            style: UIAlertAction.Style.default
        ) { [weak self] _ in
            self?.orderCheckoutPresenter.viewDidSelect(paymentMethod: .card)
        })
        alert.addAction(UIAlertAction(
            title: NSLocalizedString(TEApiPaymentMethod.cash.localized, comment: ""),
            style: UIAlertAction.Style.default
        ) { [weak self] _ in
            self?.orderCheckoutPresenter.viewDidSelect(paymentMethod: .cash)
        })
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("orderCheckoutCancelButton", comment: ""),
            style: UIAlertAction.Style.cancel,
            handler: nil)
        )
        self.present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension OrderCheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderCheckoutTableViewCell()
        if indexPath.section == 0 {
            cell.setType(.whatWillBeDelivered)
            cell.setPrimaryText(item.whatWillBeDelivered)
        } else if indexPath.section == 1 {
            cell.setType(.delivery)
            cell.setPrimaryText(item.deliveryWhen)
            cell.setSecondaryText(item.deliveryWhere)
            cell.editButton.addTarget(self, action: #selector(deliveryEditButtonTapped), for: .touchUpInside)
        } else {
            cell.setType(.payment)
            cell.setPrimaryText(item.paymentMethod)
            cell.editButton.addTarget(self, action: #selector(paymentMethodEditButtonTapped), for: .touchUpInside)
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

// MARK: - IOrderCheckoutViewController

extension OrderCheckoutViewController: IOrderCheckoutViewController {
    func startButtonLoading() {
        checkoutButton.startLoading()
    }
    
    func stopButtonLoading() {
        checkoutButton.stopLoading()
    }
    
    func set(item: OrderCheckout) {
        self.item = item
        tableView.reloadData()
    }
    
    func showCancelAlert(with title: String) {
        let alert = UIAlertController(
            title: title,
            message: "",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("orderCheckoutCancelAlertActionTitleNo", comment: ""),
            style: UIAlertAction.Style.default,
            handler: nil)
        )
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("orderCheckoutCancelAlertActionTitleYes", comment: ""),
            style: UIAlertAction.Style.default) { [weak self] _ in
                self?.orderCheckoutPresenter.yesButtonAlertTapped()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController.defaultErrorAlert()
        self.present(alert, animated: true, completion: nil)
    }
    
    func closeView() {
        self.navigationController?.popViewController(animated: true)
    }
}

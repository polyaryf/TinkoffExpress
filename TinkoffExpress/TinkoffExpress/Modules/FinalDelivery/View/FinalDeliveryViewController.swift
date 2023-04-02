//
//  FinalDeliveryViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 02.04.2023.
//

import UIKit

final class FinalDeliveryViewController: UIViewController {
    // MARK: Subviews
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Заказ оформлен"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    private lazy var tableView: UITableView = {
        var table: UITableView = .init()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private lazy var okButton: Button = {
        let config = Button.Configuration(
            // TODO: add loc enum for strings
            title: "Хорошо",
            style: .primaryTinkoff,
            contentSize: .basicLarge
        )
        // TODO: add action
        let button = Button(configuration: config, action: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Lifecycle
    
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
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(okButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(44)
            $0.left.right.equalToSuperview().inset(16)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        okButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setUpTable() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FinalDeliveryTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FinalDeliveryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FinalDeliveryTableViewCell()
        if indexPath.section == 0 {
            cell.setType(._where)
            cell.setPrimaryText("Ивангород, ул. Гагарина, д. 1")
        } else if indexPath.section == 1 {
            cell.setType(.when)
            cell.setPrimaryText("Завтра с 10:00 до 12:00")
        } else {
            cell.setType(.what)
            cell.setPrimaryText("Посылку")
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
}

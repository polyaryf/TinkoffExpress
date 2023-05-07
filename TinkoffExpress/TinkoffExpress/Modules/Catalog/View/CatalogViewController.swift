//
//  CatalogViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.05.2023.
//

import UIKit

protocol ICatalogViewController: AnyObject {}

final class CatalogViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CatalogTableViewCell.self, forCellReuseIdentifier: "productCell")
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        table.delaysContentTouches = false
        table.rowHeight = 152
        table.allowsMultipleSelection = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Setup view
    
    private func setupView() {
        setupNavigationItem()
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Каталог"
    }
    
    private func setupViewHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "productCell",
            for: indexPath
        ) as? CatalogTableViewCell {
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ICatalogViewController

extension CatalogViewController: ICatalogViewController {}

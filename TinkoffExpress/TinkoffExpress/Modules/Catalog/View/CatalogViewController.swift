//
//  CatalogViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.05.2023.
//

import UIKit

protocol ICatalogViewController: AnyObject {
    func setProducts(with products: [Product])
}

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
    
    // MARK: State
    
    private var products: [Product] = []
    
    // MARK: Dependency
    
    private let presenter: ICatalogPresenter
    
    // MARK: Init
    
    init(presenter: ICatalogPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter.viewDidLoad()
    }
    
    // MARK: Setup view
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        setupNavigationItem()
        setupTableView()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Каталог"
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
   
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
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "productCell",
            for: indexPath
        ) as? CatalogTableViewCell {
            cell.selectionStyle = .none
            cell.set(
                title: products[indexPath.row].title,
                price: products[indexPath.row].price,
                image: products[indexPath.row].image
            )
            
            cell.onCounterDidChange { counter in
                // presenter.viewDidChangeCounterOfItem(at: index)
            }
            
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

extension CatalogViewController: ICatalogViewController {
    func setProducts(with products: [Product]) {
        self.products = products
        tableView.reloadData()
    }
}

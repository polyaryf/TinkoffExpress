//
//  FinalDeliveryViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 02.04.2023.
//

import UIKit

protocol IFinalDeliveryViewController: AnyObject {
    func closeView()
}

final class FinalDeliveryViewController: UIViewController {
    // MARK: Dependencies
    
    private var presenter: FinalDeliveryPresenterProtocol
    
    // MARK: State
    
    private let item: FinalDelivery

    // MARK: Subviews
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("finalDeliveryTitle", comment: "")
        label.textColor = UIColor(named: "title.finalDelivery.color")
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
            title: NSLocalizedString("finalDeliveryButton", comment: ""),
            style: .primaryTinkoff,
            contentSize: .basicLarge
        )
        let button = Button(configuration: config) { [weak self] in
            guard let self else { return }
            self.okButtonTapped()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Init
    
    init(
        item: FinalDelivery,
        presenter: FinalDeliveryPresenterProtocol
    ) {
        self.item = item
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter.viewDidLoad()
    }
    
    // MARK: Actions
    
    private func okButtonTapped() {
        presenter.okButtonTapped()
    }
    
    // MARK: Initial Configuration
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "background.finalDelivery.color")
        
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
            $0.top.equalToSuperview().inset(44)
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
        tableView.backgroundColor = UIColor(named: "background.finalDelivery.color")
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
            cell.setPrimaryText(item.where)
        } else if indexPath.section == 1 {
            cell.setType(.when)
            cell.setPrimaryText(item.when)
        } else {
            cell.setType(.what)
            cell.setPrimaryText(item.what)
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

// MARK: - IFinalDeliveryViewController

extension FinalDeliveryViewController: IFinalDeliveryViewController {
    func closeView() {
        self.dismiss(animated: true)
    }
}

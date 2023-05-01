//
//  ABTestView.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 30.04.2023.
//

import UIKit

final class ABTestView: UIView {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ABTestTableViewCell.self, forCellReuseIdentifier: "abtest")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var doneButton: UIButton = {
        var button = UIButton.init()
        button.backgroundColor = UIColor(named: "blue.color")
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 18,
            bottom: 13,
            right: 18
        )
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        self.addSubview(tableView)
        self.addSubview(doneButton)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
            $0.width.equalTo(84)
        }
    }
    
    private func setupCell(for cell: ABTestTableViewCell, with type: ABTextCellType) {
        switch type {
        case .country:
            cell.setPlaceholder(with: "Страна")
        case .region:
            cell.setPlaceholder(with: "Регион")
        case .street:
            cell.setPlaceholder(with: "Улица")
        case .house:
            cell.setPlaceholder(with: "Строение/корпус")
        case .settlement:
            cell.setPlaceholder(with: "Населенный пункт")
        case .postalCode:
            cell.setPlaceholder(with: "Индекс")
        }
    }
}

extension ABTestView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ABTestTableViewCell()
        switch indexPath.row {
        case 0: setupCell(for: cell, with: .country)
        case 1: setupCell(for: cell, with: .region)
        case 2: setupCell(for: cell, with: .street)
        case 3: setupCell(for: cell, with: .house)
        case 4: setupCell(for: cell, with: .settlement)
        case 5: setupCell(for: cell, with: .postalCode)
        default: cell.setPlaceholder(with: "dddd")
        }
        return cell
    }
}

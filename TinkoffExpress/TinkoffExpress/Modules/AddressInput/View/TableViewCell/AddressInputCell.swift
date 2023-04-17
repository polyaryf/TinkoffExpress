//
//  AddressInputCell.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 15.04.2023.
//

import UIKit

class AddressInputCell: UITableViewCell {
    // MARK: Subviews
    
    private lazy var primaryText: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(named: "primaryText.cell.addressInput.color")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var secondaryText: FadingLabel = {
        var label = FadingLabel.init(frame: CGRect(
            x: 0,
            y: 0,
            width: 319,
            height: 16)
        )
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor(named: "secondaryText.cell.addressInput.color")
        return label
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    
    func setPrimaryText(_ text: String) {
        primaryText.text = text
    }
    
    func setSecondaryText(_ text: String) {
        secondaryText.text = text
    }
    
    // MARK: Private
    
    private func setupView() {
        contentView.addSubview(primaryText)
        contentView.addSubview(secondaryText)
        setupConstraints()
    }
    
    private func setupConstraints() {
        primaryText.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        secondaryText.snp.makeConstraints {
            $0.top.equalTo(primaryText.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}

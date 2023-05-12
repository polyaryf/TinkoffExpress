//
//  FinalDeliveryTableViewCell.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 02.04.2023.
//

import UIKit

final class FinalDeliveryTableViewCell: UITableViewCell {
    private(set) var type: FinalDeliveryCellType = .empty
    
    // MARK: Subviews
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor(named: "title.cell.finalDelivery.color")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var primaryText: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(named: "primaryText.cell.finalDelivery.color")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Public
    
    func setType(_ type: FinalDeliveryCellType) {
        self.type = type
        updateView()
    }
    
    func setPrimaryText(_ text: String) {
        primaryText.text = NSLocalizedString(text, comment: "")
    }
    
    // MARK: Private
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(primaryText)
        contentView.backgroundColor = UIColor(named: "background.finalDelivery.color")
    
        titleLabel.text = NSLocalizedString(type.rawValue, comment: "")
        
        setupCellConsrtaints()
    }
    
    private func setupCellConsrtaints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView)
        }
        primaryText.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
    
    // MARK: Update
    
    private func updateView() {
        setupView()
    }
}

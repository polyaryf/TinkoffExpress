//
//  OrderCheckoutTableViewCell.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit

final class OrderCheckoutTableViewCell: UITableViewCell {
    private(set) var type: OrderCheckoutCellType = .empty
    
    // MARK: Subviews
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(named: "title.cell.orderCheckout.color")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var primaryText: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(named: "primaryText.cell.orderCheckout.color")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var secondaryText: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor(named: "secondaryText.cell.orderCheckout.color")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var cellImageView: UIImageView = {
        var imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 56, height: 56)))
        imageView.image = UIImage(named: "cart")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var editButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Изменить", for: .normal)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        contentView.backgroundColor = UIColor(named: "backgroundColor.orderCheckout")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Public
    
    func setType(_ type: OrderCheckoutCellType) {
        self.type = type
        updateView()
    }
    
    func setPrimaryText(_ text: String) {
        primaryText.text = text
    }
    
    func setSecondaryText(_ text: String) {
        secondaryText.text = text
    }
    
    // MARK: Private
    
    private func setupView() {
        switch type {
        case .empty: return
        case .whatWillBeDelivered: setupWhatWillBeDeliveredCellView()
        case .delivery: setupDeliveryCellView()
        case .payment: setupPaymentCellView()
        }
    }
    
    private func setupWhatWillBeDeliveredCellView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(cellImageView)
        contentView.addSubview(primaryText)
        
        whatWillBeDeliveredCellConsrtaints()
        
        titleLabel.text = type.rawValue
    }
    
    private func setupDeliveryCellView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(primaryText)
        contentView.addSubview(secondaryText)
        
        deliveryCellConsrtaints()
        
        titleLabel.text = type.rawValue
    }
    
    private func setupPaymentCellView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(primaryText)
        
        paymentCellConsrtaints()
        
        titleLabel.text = type.rawValue
    }
    
    // MARK: Consrtaints
    
    private func whatWillBeDeliveredCellConsrtaints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.left.equalTo(contentView)
            $0.bottom.equalTo(contentView.snp.top).offset(24)
        }
        cellImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(21)
            $0.centerY.equalTo(primaryText)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        primaryText.snp.makeConstraints {
            $0.left.equalTo(contentView).offset(16 + 40)
        }
    }
    
    private func deliveryCellConsrtaints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.left.equalTo(contentView)
            $0.bottom.equalTo(contentView.snp.top).offset(24)
        }
        editButton.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.right.equalTo(contentView)
            $0.height.equalTo(titleLabel)
        }
        primaryText.snp.makeConstraints {
            $0.left.equalTo(contentView)
            $0.top.equalTo(titleLabel.snp.bottom).offset(21)
        }
        secondaryText.snp.makeConstraints {
            $0.left.equalTo(contentView)
            $0.top.equalTo(primaryText.snp.bottom)
        }
    }
    
    private func paymentCellConsrtaints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.left.equalTo(contentView)
            $0.bottom.equalTo(contentView.snp.top).offset(24)
        }
        editButton.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.right.equalTo(contentView)
            $0.height.equalTo(titleLabel)
        }
        primaryText.snp.makeConstraints {
            $0.left.equalTo(contentView)
            $0.top.equalTo(titleLabel.snp.bottom).offset(21)
        }
    }
    
    // MARK: Update
    
    private func updateView() {
        setupView()
    }
}
    

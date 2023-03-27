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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var editButton: UIButton = {
        var button = UIButton(type: .system)
        // TODO: убрать хардкод всех надписей
        button.setTitle("Изменить", for: .normal)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var text: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var secondaryText: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var cellImageView: UIImageView = {
        var imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 56, height: 56)))
        imageView.image = UIImage(systemName: "square.and.arrow.up.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    func setType(_ type: OrderCheckoutCellType) {
        self.type = type
        updateView()
    }
    
    // MARK: Private
    
    private func setupView() {
        switch(type) {
        case .empty: return
        case .whatWillBeDelivered: setupWhatWillBeDeliveredCellView()
        case .delivery: setupDeliveryCellView()
        case .payment: setupPaymentCellView()
        }
    }
    
    private func setupWhatWillBeDeliveredCellView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(cellImageView)
        contentView.addSubview(text)
        
        whatWillBeDeliveredCellConsrtaints()
        
        titleLabel.text = type.rawValue
        text.text = "Посылку"
    }
    
    private func setupDeliveryCellView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(text)
        contentView.addSubview(secondaryText)
        
        deliveryCellConsrtaints()
        
        titleLabel.text = type.rawValue
        text.text = "Завтра с 10:00 до 12:00"
        secondaryText.text = "Ивангород, ул. Гагарина, д. 1"
    }
    
    private func setupPaymentCellView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(text)
        
        titleLabel.text = type.rawValue
    }
    
    // MARK: Consrtaints
    
    private func whatWillBeDeliveredCellConsrtaints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(28)
            $0.left.equalTo(contentView)
            $0.bottom.equalTo(contentView.snp.top).offset(60)
        }
        cellImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(72)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        text.snp.makeConstraints {
            $0.left.equalTo(cellImageView.snp.right).offset(16)
            $0.top.equalTo(contentView).offset(82)
        }
    }
    
    private func deliveryCellConsrtaints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(28)
            $0.left.equalTo(contentView)
            $0.bottom.equalTo(contentView.snp.top).offset(60)
        }
        editButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.right.equalTo(contentView)
            $0.bottom.equalTo(contentView.snp.top).offset(60)
            $0.height.equalTo(titleLabel)
        }
        text.snp.makeConstraints {
            $0.left.equalTo(contentView)
            $0.top.equalTo(contentView).offset(89)
        }
        secondaryText.snp.makeConstraints {
            $0.left.equalTo(contentView)
            $0.top.equalTo(text.snp.bottom)
        }
    }
    
    // MARK: Update
    
    private func updateView() {
        setupView()
    }
}
    

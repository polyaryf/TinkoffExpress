//
//  OrderCheckoutTableViewCell.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit

final class OrderCheckoutTableViewCell: UITableViewCell {
    // MARK: Subviews
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    private lazy var editButton: UIButton = {
        var button = UIButton()
        return button
    }()
    private lazy var text: UILabel = {
        var label = UILabel()
        return label
    }()
    private lazy var secondaryText: UILabel = {
        var label = UILabel()
        return label
    }()
    private lazy var cellImageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Private
    
    private func setupView() {}
}
    

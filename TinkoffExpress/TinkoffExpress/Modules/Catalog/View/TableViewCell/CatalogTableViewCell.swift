//
//  CatalogTableViewCell.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.05.2023.
//

import UIKit

final class CatalogTableViewCell: UITableViewCell {
    // MARK: Subviews
    
    private lazy var containerView = UIView()
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1200"
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let newScale: CGFloat = highlighted ? 0.95 : 1.0
        UIView.animate(withDuration: 0.1) {
            self.containerView.transform = CGAffineTransform(scaleX: newScale, y: newScale)
        }
    }
    
    // MARK: Setup view
    
    private func setupView() {
        setupViewHierarchy()
        setupContentView()
        setupImageView()
        setupConstraints()
    }
    
    private func setupContentView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(named: "cartCellColor")
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = false

        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImage)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(plusButton)
        containerView.addSubview(counterLabel)
        containerView.addSubview(minusButton)
    }
    
    private func setupImageView() {
        let sizeImageView = CGRect(x: 0, y: 0, width: 100, height: 100)
        productImage.frame = sizeImageView
        productImage.layer.cornerRadius = productImage.bounds.size.width / 2
        productImage.clipsToBounds = true
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        productImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(productImage.snp.top)
            $0.left.equalTo(productImage.snp.right).offset(16)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.equalTo(productImage.snp.right).offset(16)
        }
        plusButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
        }
        counterLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(plusButton.snp.left).offset(-(plusButton.frame.width + 10))
        }
        minusButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(counterLabel.snp.left).offset(-(counterLabel.frame.width + 10))
        }
    }
}

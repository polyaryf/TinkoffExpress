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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
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
        label.textAlignment = .center
        label.text = "\(counter)"
        if counter == 0 {
            label.isHidden = true
        }
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(increaseCounter), for: .touchUpInside)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(decreaseCounter), for: .touchUpInside)

        if counter == 0 {
            button.isHidden = true
        }
        return button
    }()
    
    // MARK: Callbacks

    private var onCounterDidChangeAction: ((Int) -> Void)?
    
    // MARK: State
    
    private var counter: Int = 0
    
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
        counterLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-18)
            $0.width.equalTo(25)
        }
        plusButton.snp.makeConstraints {
            $0.bottom.equalTo(counterLabel.snp.top).offset(-(counterLabel.frame.height + 10))
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        minusButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalTo(counterLabel.snp.bottom).offset((counterLabel.frame.height + 10))
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(productImage.snp.top)
            $0.left.equalTo(productImage.snp.right).offset(16)
            $0.right.equalTo(minusButton.snp.left).offset(-10)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.equalTo(productImage.snp.right).offset(16)
        }
    }
    
    // MARK: Update View
    
    private func updateView() {
        counterLabel.text = "\(counter)"
        
        if counter > 0 {
            minusButton.isHidden = false
            counterLabel.isHidden = false
        } else {
            minusButton.isHidden = true
            counterLabel.isHidden = true
        }
    }
    
    // MARK: Public
    
    func set(title: String, price: String, image: String) {
        titleLabel.text = title
        priceLabel.text = price
        productImage.image = UIImage(named: "\(image)")
    }
    
    func onCounterDidChange(_ action: @escaping (Int) -> Void) {
        onCounterDidChangeAction = action
    }
    
    @objc private func increaseCounter() {
        counter += 1
        
        onCounterDidChangeAction?(counter)
        updateView()
    }
    
    @objc private func decreaseCounter() {
        if counter == 0 {
            return
        }
        counter -= 1
        onCounterDidChangeAction?(counter)
        updateView()
    }
}

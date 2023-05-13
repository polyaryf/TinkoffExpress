//
//  CartCell.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit
import SnapKit

final class CartCell: UICollectionViewCell {
    // MARK: Subviews
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(increaseCounter), for: .touchUpInside)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(decreaseCounter), for: .touchUpInside)
        return button
    }()
    
    // MARK: Callbacks

    private var onCounterDidIncrease: (() -> Void)?
    private var onCounterDidDecrease: (() -> Void)?
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    override var isHighlighted: Bool {
        didSet {
            let newScale: CGFloat = isHighlighted ? 0.95 : 1.0
            UIView.animate(withDuration: 0.3) {
                self.transform = CGAffineTransform(scaleX: newScale, y: newScale)
            }
        }
    }
    
    func set(text: String, imageName: String, count: String) {
        label.text = text
        imageView.image = UIImage(named: imageName)
        countLabel.text = count
    }
    
    // MARK: Setup Subviews
    
    private func setupView() {
        contentView.backgroundColor = UIColor(named: "cartCellColor")
        
        setupContentView()
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(plusButton)
        contentView.addSubview(minusButton)
        contentView.addSubview(countLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        label.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(16)
            make.centerY.equalToSuperview()
        }
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-9)
            $0.width.equalTo(25)
        }
        plusButton.snp.makeConstraints {
            $0.bottom.equalTo(countLabel.snp.top).offset(-(countLabel.frame.height + 10))
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(25)
            $0.height.equalTo(25)
        }
        minusButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalTo(countLabel.snp.bottom).offset((countLabel.frame.height + 10))
            $0.width.equalTo(25)
            $0.height.equalTo(25)
        }
    }
    
    func onCounterDidIncrease(_ action: @escaping () -> Void) {
        onCounterDidIncrease = action
    }
    
    func onCounterDidDecrease(_ action: @escaping () -> Void) {
        onCounterDidDecrease = action
    }
    
    // MARK: Action
    
    @objc private func increaseCounter() {
        onCounterDidIncrease?()
    }
    
    @objc private func decreaseCounter() {
        onCounterDidDecrease?()
    }
}

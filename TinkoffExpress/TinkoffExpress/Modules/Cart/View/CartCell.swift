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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2
        imageView.clipsToBounds = true
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
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset((contentView.bounds.height - 40) / 2)
        }
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        plusButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
        countLabel.snp.makeConstraints {
            $0.right.equalTo(plusButton.snp.left).offset(-6)
            $0.centerY.equalToSuperview()
        }
        minusButton.snp.makeConstraints {
            $0.right.equalTo(plusButton.snp.left).offset(-27)
            $0.centerY.equalToSuperview()
        }
    }
    
    func onCounterDidChange(_ action: @escaping (Int) -> Void) {
        onCounterDidChangeAction = action
    }
    
    // MARK: Action
    
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
    
    // MARK: Update View
    
    private func updateView() {
        countLabel.text = "\(counter)"
        
        if counter > 0 {
            minusButton.isHidden = false
            countLabel.isHidden = false
        } else {
            minusButton.isHidden = true
            countLabel.isHidden = true
        }
    }
}

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
    
    private lazy var label = UILabel()
    private lazy var imageView = UIImageView()
    private lazy var countLabel = UILabel()
    
    // MARK: Sizes
    
    private lazy var sizeImageView = CGRect(x: 0, y: 0, width: 40, height: 40)
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupImageView()
        setupLabel()
        setupCountLabel()
        setupColors()
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
    
    // MARK: Setup Colors
    
    func setupColors() {
        contentView.backgroundColor = UIColor(named: "cartCellColor")
        label.textColor = UIColor(named: "textColor")
    }
    
    // MARK: Setup Subviews
    
    func setupCell(text: String, imageName: String, count: String) {
        label.text = text
        imageView.image = UIImage(named: imageName)
        countLabel.text = count
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = false

        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
    }
    
    private func setupImageView() {
        imageView.frame = sizeImageView
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(sizeImageView.width)
            make.height.equalTo(sizeImageView.height)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset((contentView.bounds.height - sizeImageView.width) / 2)
        }
    }
    
    private func setupLabel() {
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupCountLabel() {
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        contentView.addSubview(countLabel)
        
        countLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
}

//
//  MyOrdersCell.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import UIKit
import SnapKit

final class MyOrdersCell: UICollectionViewCell {
    // MARK: Subviews
    
    private lazy var label = UILabel()
    private lazy var descriptionLabel = UILabel()
    private lazy var imageView = UIImageView()
    
    // MARK: Sizes
    
    private lazy var sizeImageView = CGRect(x: 0, y: 0, width: 40, height: 40)
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupImageView()
        setupLabel()
        setupDescription()
        setupColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Colors
    
    private func setupColors() {
        contentView.backgroundColor = UIColor(named: "deliveryCellColor")
        label.textColor = UIColor(named: "textColor")
    }
    
    // MARK: Setup Subviews
    
    func setupCell(description: String, imageName: String) {
        label.text = NSLocalizedString("myOrdersDelivery", comment: "")
        descriptionLabel.text = description
        imageView.image = UIImage(named: imageName)
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
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(sizeImageView.width)
            make.height.equalTo(sizeImageView.height)
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupLabel() {
        label.textColor = UIColor(named: "myOrdersDeliveryTextColor")
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(19)
        }
    }
    
    private func setupDescription() {
        descriptionLabel.textColor = UIColor(named: "myOrdersDeliveryTextColor")
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.top.equalTo(label.snp.bottom).offset(4)
        }
    }
    
    // MARK: Animation
    
    override var isHighlighted: Bool {
        didSet {
            let newScale: CGFloat = isHighlighted ? 0.95 : 1.0
            UIView.animate(withDuration: 0.3) {
                self.transform = CGAffineTransform(scaleX: newScale, y: newScale)
            }
        }
    }
}

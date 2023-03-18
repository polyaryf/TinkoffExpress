//
//  DeliveryCell.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit
import SnapKit

final class DeliveryCell: UICollectionViewCell {
    private lazy var label = UILabel()
    private lazy var imageView = UIImageView()
    
    private lazy var sizeImageView = CGRect(x: 0, y: 0, width: 45, height: 45)
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Setup
extension DeliveryCell {
    private func setupSubviews() {
        // Configure label
        label.text = "Доставка"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        // Configure imageView
        imageView.image = UIImage(named: "deliveryIcon")
        imageView.frame = sizeImageView
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2
        imageView.clipsToBounds = true
        
        // Configure cell appearance
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = false
        
        // Add shadow
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        
        // Add subviews
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        
        // Add constraints using SnapKit
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(sizeImageView.width)
            make.height.equalTo(sizeImageView.height)
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset((sizeImageView.width - contentView.bounds.height) / 2)
        }
    }
}


// MARK: - Animation
extension DeliveryCell {
    override var isHighlighted: Bool {
        didSet {
            let newScale: CGFloat = isHighlighted ? 0.95 : 1.0
            UIView.animate(withDuration: 0.3) {
                self.transform = CGAffineTransform(scaleX: newScale, y: newScale)
            }
        }
    }
}

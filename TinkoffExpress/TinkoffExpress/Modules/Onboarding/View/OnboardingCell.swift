//
//  OnboardingCell.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit
import SnapKit

final class OnboardingCell: UICollectionViewCell {
    // MARK: Subviews
    
    private lazy var label = UILabel()
    private lazy var imageView = UIImageView()
    
    // MARK: Sizes
    
    private lazy var sizeImageView = CGRect(x: 0, y: 0, width: 80, height: 80)
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
        setupLabel()
        setupColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Colors
    
    private func setupColors() {
        label.textColor = UIColor(named: "textColor")
    }
    
    // MARK: Setup Subviews
    
    func setupCell(text: String, imageName: String) {
        label.text = text
        imageView.image = UIImage(named: imageName)
    }

    private func setupImageView() {
        imageView.frame = sizeImageView
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.equalTo(sizeImageView.width)
            make.height.equalTo(sizeImageView.height)
        }
    }
    
    private func setupLabel() {
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 2
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

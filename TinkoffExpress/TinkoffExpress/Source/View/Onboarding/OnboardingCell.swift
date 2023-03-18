//
//  OnboardingCell.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit
import SnapKit

final class OnboardingCell: UICollectionViewCell {
    // MARK: Subviews
    
    private lazy var label = UILabel()
    private lazy var imageView = UIImageView()
    
    private lazy var sizeImageView = CGRect(x: 0, y: 0, width: 90, height: 90)
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupImageView()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Subviews
    
    private func setupContentView() {
        contentView.backgroundColor = .white
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: "onboardingLetter")
        imageView.frame = sizeImageView
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(sizeImageView.width)
            make.height.equalTo(sizeImageView.height)
        }
    }
    
    private func setupLabel() {
        label.text = "Курьер доставит посылку в указанное время"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 2
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
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

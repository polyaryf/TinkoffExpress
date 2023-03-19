//
//  OnboardingHeaderView.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit
import SnapKit

final class OnboardingHeaderView: UICollectionReusableView {
    // MARK: Subviews
    
    private lazy var titleLabel = UILabel()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Subviews
    
    private func setupTitleLabel() {
        titleLabel.text = "Оформите\nбесплатную доставку"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 33)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

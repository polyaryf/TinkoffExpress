//
//  DeliveryHeaderView.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit
import SnapKit

final class DeliveryHeaderView: UICollectionReusableView {
    // MARK: Subviews
    
    private lazy var titleLabel = UILabel()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTitleLabel()
        setupColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Colors
    
    private func setupColors() {
        titleLabel.textColor = UIColor(named: "textColor")
    }
    
    // MARK: Setup Subviews
    
    private func setupTitleLabel() {
        titleLabel.text = "Выберите\nспособ получения"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.numberOfLines = 2
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
}

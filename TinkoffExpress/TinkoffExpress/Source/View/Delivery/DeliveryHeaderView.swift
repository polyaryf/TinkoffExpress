//
//  DeliveryHeaderView.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit
import SnapKit

final class DeliveryHeaderView: UICollectionReusableView {
    private lazy var titleLabel = UILabel()
    
    // Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Setup
extension DeliveryHeaderView {
    private func setupTitleLabel() {
        // Configure titleLabel
        titleLabel.text = "Выберите\nспособ получения"
        let largeTitleDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
        let boldDescriptor = largeTitleDescriptor.withSymbolicTraits(.traitBold)!
        titleLabel.font = UIFont(descriptor: boldDescriptor, size: 0)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        // Add Subview
        addSubview(titleLabel)
        
        // Add Constraints using SnapKit
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

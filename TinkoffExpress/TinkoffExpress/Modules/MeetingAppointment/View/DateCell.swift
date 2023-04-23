//
//  DateCell.swift
//  TinkoffExpress
//
//  Created by zedsbook on 26.03.2023.
//

import Foundation
import SnapKit

final class DateCell: UICollectionViewCell {
    // MARK: Subviews
    
    private lazy var dateLabel = UILabel()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupDateLabel()
        setupColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor =
            isSelected ? UIColor(named: "selectedDateCellColor") : UIColor(named: "dateCellColor")
            dateLabel.textColor = isSelected ? .white : UIColor(named: "textColor")
            contentView.layer.cornerRadius = 15
        }
    }
    
    // MARK: Setup Colors
    
    private func setupColors() {
        contentView.backgroundColor = UIColor(named: "dateCellColor")
        dateLabel.textColor = UIColor(named: "textColor")
    }
    
    // MARK: Setup Subviews
    
    func setupCell(text: String) {
        dateLabel.text = text
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 15
    }
    
    private func setupDateLabel() {
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        dateLabel.numberOfLines = 1
        
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

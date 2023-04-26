//
//  TimeCell.swift
//  TinkoffExpress
//
//  Created by zedsbook on 26.03.2023.
//

import Foundation
import SnapKit

final class TimeCell: UICollectionViewCell {
    // MARK: Subviews
    
    private lazy var timeLabel = UILabel()
    private lazy var dateLabel = UILabel()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupTimeLabel()
        setupDateLabel()
        setupColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderColor =
            isSelected ? UIColor(named: "selectedTimeCellColor")?.cgColor : UIColor(named: "timeCellColor")?.cgColor
            contentView.layer.borderWidth = isSelected ? 2 : 0
            contentView.layer.cornerRadius = 15
        }
    }
    
    // MARK: Setup Colors
    
    private func setupColors() {
        contentView.backgroundColor = UIColor(named: "timeCellColor")
        timeLabel.textColor = UIColor(named: "textColor")
        dateLabel.textColor = UIColor(named: "timeCellDateLabelColor")
    }
    
    // MARK: Setup Subviews
    
    func setupCell(timeText: String, dateText: String) {
        timeLabel.text = timeText
        dateLabel.text = dateText
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 15

        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
    }
    
    private func setupTimeLabel() {
        timeLabel.textAlignment = .left
        timeLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        timeLabel.numberOfLines = 1
        
        contentView.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(18)
        }
    }
    
    private func setupDateLabel() {
        dateLabel.textAlignment = .left
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        dateLabel.numberOfLines = 1
        
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(16)
        }
    }
}

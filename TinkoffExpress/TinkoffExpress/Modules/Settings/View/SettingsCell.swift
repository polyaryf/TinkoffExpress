//
//  SettingsCell.swift
//  TinkoffExpress
//
//  Created by zedsbook on 06.05.2023.
//

import UIKit
import SnapKit

final class SettingsCell: UICollectionViewCell {
    // MARK: Subviews
    
    private lazy var label = UILabel()
    private lazy var descriptionLabel = UILabel()
    private lazy var imageView = UIImageView()
    private lazy var toggle = UISwitch()
    
    // MARK: Sizes
    
    private lazy var sizeImageView = CGRect(x: 0, y: 0, width: 40, height: 40)
    
    // MARK: Callback
    
    private var onToggleSwitchDidChange: ((Bool) -> Void)?
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupLabel()
        setupDescription()
        setupToggle()
        setupColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Action
    
    func onToggleSwitchDidChange(_ action: @escaping (Bool) -> Void) {
        onToggleSwitchDidChange = action
    }
    
    @objc private func toggleSwitchDidChange(_ sender: UISwitch) {
        onToggleSwitchDidChange?(sender.isOn)
        descriptionLabel.text = sender.isOn ?
            NSLocalizedString(Search.standard.rawValue, comment: "") :
            NSLocalizedString(Search.detailed.rawValue, comment: "")
    }
    
    // MARK: Setup Colors
    
    private func setupColors() {
        contentView.backgroundColor = UIColor(named: "deliveryCellColor")
        label.textColor = UIColor(named: "textColor")
    }
    
    // MARK: Setup Subviews
    
    func setupCell(text: String, description: String, imageName: String, isActive: Bool) {
        label.text = text
        descriptionLabel.text = description
        imageView.image = UIImage(named: imageName)
        toggle.isOn = isActive
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = false

        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
    }
    
    private func setupLabel() {
        label.textColor = UIColor(named: "myOrdersDeliveryTextColor")
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(19)
        }
    }
    
    private func setupDescription() {
        descriptionLabel.textColor = UIColor(named: "myOrdersDeliveryTextColor")
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(label.snp.bottom).offset(4)
        }
    }
    
    private func setupToggle() {
        contentView.addSubview(toggle)
        
        toggle.addTarget(
            self,
            action: #selector(toggleSwitchDidChange(_:)),
            for: .valueChanged
        )
        
        toggle.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
}

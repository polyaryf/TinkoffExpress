//
//  ABTestTableViewCell.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 01.05.2023.
//

import UIKit

final class ABTestTableViewCell: UITableViewCell {
    // MARK: Subview
    
    private lazy var textField: TextField = {
        let textField = TextField()
        textField.modifyClearButtonWithImage(
            image: UIImage(named: "x.cross.addressInput")
        )
        textField.tintColor = UIColor(named: "blue.color")
        textField.backgroundColor = UIColor(named: "inputTextView.abtest.color")
        textField.textColor = UIColor(named: "inputText.abtest.color")
        textField.font = .systemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 16
        textField.clipsToBounds = true
        return textField
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func setupView() {
        contentView.addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: Public
    
    func setPlaceholder(with text: String) {
        textField.placeholder = text
    }
}

//
//  TextView+Extension.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 18.04.2023.
//

import UIKit

extension TextView {
    func setClearButton(superViewSize: CGRect) {
        let clearTextButton = UIButton()
        clearTextButton.setImage(UIImage(named: "x.cross.addressInput"), for: .normal)
        clearTextButton.translatesAutoresizingMaskIntoConstraints = false
        clearTextButton.tag = 111
        clearTextButton.isHidden = self.text.isEmpty

        self.addSubview(clearTextButton)
        
        let side: CGFloat = 16
        let trailing: CGFloat = 12
        let leading = superViewSize.width - side * 3 - trailing
        clearTextButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(side)
            $0.width.equalTo(side)
            $0.leading.equalToSuperview().offset(leading)
            $0.trailing.equalToSuperview().offset(-trailing)
        }
    }
    
    func checkClearTextButton() {
        let clearTextButton = self.viewWithTag(111) as? UIButton
        clearTextButton?.isHidden = self.text.isEmpty
    }
    
    func setPlaceholder() {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Адрес"
        placeholderLabel.font = UIFont.systemFont(ofSize: 17)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 222
        placeholderLabel.frame.origin.x = self.frame.origin.x + 20
        placeholderLabel.frame.origin.y = self.frame.origin.y + 18
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !self.text.isEmpty

        self.addSubview(placeholderLabel)
    }

    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(222) as? UILabel
        placeholderLabel?.isHidden = !self.text.isEmpty
    }
}

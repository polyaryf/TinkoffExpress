//
//  TextView+Extension.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 18.04.2023.
//

import UIKit

extension TextView {
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

//
//  TextField.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 01.05.2023.
//

import UIKit

class TextField: UITextField {
    let padding = UIEdgeInsets(
        top: 20,
        left: 12,
        bottom: 20,
        right: 20
    )
    
    let btnPadding = UIEdgeInsets(
        top: 0,
        left: -36,
        bottom: 0,
        right: -20
    )
        
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func modifyClearButtonWithImage(image: UIImage?) {
        guard let image else { return }
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal)
        clearButton.imageEdgeInsets = btnPadding
        clearButton.addTarget(self, action: #selector(TextField.clear(_:) ), for: .touchUpInside)
        self.rightView = clearButton
        self.rightViewMode = .whileEditing
    }

    @objc func clear(_ sender: AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
    }
}

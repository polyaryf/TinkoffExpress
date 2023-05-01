//
//  ABTestView+TextFieldDelegate.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 01.05.2023.
//

import UIKit

extension ABTestView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nextViewBecomeFirstResponder(after: textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField as? TextField
        checkDoneButton()
    }
}

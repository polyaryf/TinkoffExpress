//
//  UIAlertController+Utils.swift
//  TinkoffExpress
//
//  Created by Руслан Ахмадеев on 07.05.2023.
//

import UIKit

extension UIAlertController {
    static func defaultErrorAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: NSLocalizedString("defaultErrorAlertTitle", comment: ""),
            message: NSLocalizedString("defaultErrorAlertMessage", comment: ""),
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: NSLocalizedString("defaultErrorAlertActionTitle", comment: ""), style: .default)
        alert.addAction(action)
        return alert
    }
}

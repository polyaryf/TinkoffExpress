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
            title: "Что-то пошло не так",
            message: "Попробуйте оформить позже",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "Понятно", style: .default)
        alert.addAction(action)
        return alert
    }
}

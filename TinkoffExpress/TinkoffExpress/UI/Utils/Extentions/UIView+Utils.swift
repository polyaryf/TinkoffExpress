//
//  UIView+Utils.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit

extension UIView {
    func pinEdgesToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            assertionFailure("\(self) does not have a superview")
            return
        }

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        ])
    }
}

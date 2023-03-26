//
//  UIColor+Highlight.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit

extension UIColor {
    func highlighted(
        settings: HighlightSettings = .default
    ) -> UIColor {
        let traitCollection: UITraitCollection = {
            if #available(iOS 13, *) {
                return .current
            } else {
                return UIScreen.main.traitCollection
            }
        }()

        let color: UIColor = {
            if #available(iOS 13, *) {
                return resolvedColor(with: traitCollection)
            } else {
                return self
            }
        }()

        return color
            .hsbaColor
            .highlighted(
                theme: traitCollection.theme,
                settings: settings
            ).uiColor
    }
}

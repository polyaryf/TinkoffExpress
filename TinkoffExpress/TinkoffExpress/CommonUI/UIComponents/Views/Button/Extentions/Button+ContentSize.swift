//
//  Button+ContentSize.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit

extension Button.ContentSize {
    static var basicSmall: Button.ContentSize {
        Button.ContentSize(
            titleFont: .systemFont(ofSize: 13, weight: .semibold),
            cornersStyle: .rounded(radius: 12),
            activityIndicatorDiameter: 20,
            imagePadding: 4,
            preferredHeight: 30,
            contentInsets: UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        )
    }

    static var basicMedium: Button.ContentSize {
        Button.ContentSize(
            titleFont: .systemFont(ofSize: 15, weight: .regular),
            cornersStyle: .rounded(radius: 12),
            activityIndicatorDiameter: 24,
            imagePadding: 8,
            preferredHeight: 44,
            contentInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        )
    }

    static var basicLarge: Button.ContentSize {
        Button.ContentSize(
            titleFont: .systemFont(ofSize: 17, weight: .regular),
            cornersStyle: .rounded(radius: 16),
            activityIndicatorDiameter: 24,
            imagePadding: 8,
            preferredHeight: 56,
            contentInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        )
    }
}

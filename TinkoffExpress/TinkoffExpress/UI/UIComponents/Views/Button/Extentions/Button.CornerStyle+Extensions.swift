//
//  Button.CornerStyle+Extensions.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit

extension Button.CornersStyle {
    func cornerRadius(for bounds: CGRect) -> CGFloat {
        switch self {
        case .none:
            return .zero
        case let .rounded(radius):
            return radius
        }
    }
}

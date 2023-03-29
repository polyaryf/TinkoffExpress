//
//  Button.Style+Extensions.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit

extension Button.Style {
    static var clear: Button.Style {
        Button.Style(foregroundColor: .clear, backgroundColor: .clear)
    }

    // MARK: Design System

    static var primaryTinkoff: Button.Style {
        Button.Style(
            foregroundColor: Button.InteractiveColor(
                normal: TEColors.Text.primaryOnTinkoff.color
            ),
            backgroundColor: Button.InteractiveColor(
                normal: TEColors.Foreground.brandTinkoffAccent
            )
        )
    }

    static var secondary: Button.Style {
        Button.Style(
            foregroundColor: Button.InteractiveColor(
                normal: TEColors.Text.accent.color
            ),
            backgroundColor: Button.InteractiveColor(
                normal: TEColors.Background.neutral1.color
            )
        )
    }

    static var flat: Button.Style {
        Button.Style(
            foregroundColor: Button.InteractiveColor(
                normal: TEColors.Text.accent.color
            ),
            backgroundColor: Button.InteractiveColor(
                normal: .clear,
                highlighted: TEColors.Background.neutral1.color,
                disabled: .clear
            )
        )
    }

    static var destructive: Button.Style {
        Button.Style(
            foregroundColor: Button.InteractiveColor(
                normal: TEColors.Text.negative.color
            ),
            backgroundColor: Button.InteractiveColor(
                normal: TEColors.Background.neutral1.color
            )
        )
    }
}

//
//  Button+Configuration.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit

extension Button {
    struct Configuration: Equatable {
        var title: String?
        var image: UIImage?
        var style: Style = .clear
        var contentSize = ContentSize()
        var imagePlacement: ImagePlacement = .leading
        var isLoading = false
    }

    struct Style: Equatable {
        var foregroundColor: InteractiveColor
        var backgroundColor: InteractiveColor
    }

    struct ContentSize: Equatable {
        var titleFont: UIFont?
        var cornersStyle: CornersStyle = .none
        var activityIndicatorDiameter: CGFloat = .zero
        var imagePadding: CGFloat = .zero
        var preferredHeight: CGFloat = .zero
        var contentInsets: UIEdgeInsets = .zero
    }

    enum CornersStyle: Equatable {
        case none
        case rounded(radius: CGFloat)
    }

    struct InteractiveColor: Equatable {
        var normal: UIColor
        var highlighted: UIColor?
        var disabled: UIColor?
    }

    enum ImagePlacement {
        case leading
        case trailing
    }
}

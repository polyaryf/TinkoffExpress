//
//  ActivityIndicatorView.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit

final class ActivityIndicatorView: UIView {
    /// Флаг активности анимации
    private(set) var isAnimating = false
    
    // Private/Computed
    private lazy var circle: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = style?.width ?? Constants.Layout.width
        layer.addSublayer(shapeLayer)
        setNeedsLayout()

        return shapeLayer
    }()
    
    // MARK: - Lifecycle
    init(style: Style = Style()) {
        super.init(frame: .zero)

        accessibilityIdentifier = String(describing: ActivityIndicatorView.self)
        apply(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - TCSStylable

    var style: Style?

    func apply(style: Style) {
        self.style = style

        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius ?? Constants.Layout.cornerRadius
        circle.strokeColor = style.lineColor.cgColor
        circle.lineCap = style.lineCap

        if let shadow = style.shadow {
            dropShadow(with: shadow)
        }
    }

    // MARK: - Style

    struct Style {
        static var standart: ActivityIndicatorView.Style {
            ActivityIndicatorView.Style()
        }

        static var xlYellow: ActivityIndicatorView.Style {
            ActivityIndicatorView.Style(
                lineColor: TEColors.Foreground.brandTinkoffAccent,
                diameter: 72,
                width: 4
            )
        }

        var backgroundColor: UIColor
        var lineColor: UIColor
        var cornerRadius: CGFloat?
        var padding: CGFloat?
        var diameter: Double
        var width: CGFloat
        let shadow: ShadowStyle?
        let lineCap: CAShapeLayerLineCap

        init(
            backgroundColor: UIColor = .clear,
            lineColor: UIColor = .black,
            cornerRadius: CGFloat? = nil,
            padding: CGFloat? = nil,
            diameter: Double = 20,
            width: CGFloat = 2,
            shadow: ShadowStyle? = nil,
            lineCap: CAShapeLayerLineCap = .round
        ) {
            self.backgroundColor = backgroundColor
            self.lineColor = lineColor
            self.cornerRadius = cornerRadius
            self.diameter = diameter
            self.padding = padding
            self.width = width
            self.shadow = shadow
            self.lineCap = lineCap
        }
    }
}

private enum Constants {
    /// Константы для анимации
    enum Animation {
        static let strokeAnimation = "strokeAnimation"
        static let rotationAnimation = "rotationAnimation"

        static let layerStrokeStartAnimation = "strokeStart"
        static let layerStrokeEndAnimation = "strokeEnd"
        static let layerTransformRotationZAnimation = "transform.rotation.z"

        static let duration300ms: Double = 0.3
        static let duration3s: Double = 3

        static let rotationMultiplier: Double = 3
    }

    /// Константы для лэйаута
    enum Layout {
        static let cornerRadius: CGFloat = 8
        static let padding: CGFloat = 0
        static let radius: Double = 12
        static let width: CGFloat = 2
        static let size = CGSize(width: radius * 2, height: radius * 2)
    }
}

private extension ActivityIndicatorView {
    var size: CGSize {
        guard let diameter = style?.diameter else { return Constants.Layout.size }

        let padding = style?.padding ?? Constants.Layout.padding
        let widthHeight = diameter + Double(padding)

        return CGSize(width: widthHeight, height: widthHeight)
    }
}

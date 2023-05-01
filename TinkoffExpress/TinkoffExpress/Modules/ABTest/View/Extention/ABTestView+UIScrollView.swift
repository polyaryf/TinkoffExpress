//
//  ABTestView+UIScrollView.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 01.05.2023.
//

import UIKit

extension UIScrollView {
    func scrollToView(view: UIView, animated: Bool) {
        if let origin = view.superview {
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            self.scrollRectToVisible(
                CGRect(
                    x: 0,
                    y: childStartPoint.y,
                    width: 1,
                    height: self.frame.height
                ),
                animated: animated
            )
        }
    }
}

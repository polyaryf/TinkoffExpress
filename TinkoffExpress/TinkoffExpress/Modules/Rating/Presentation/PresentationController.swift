//
//  PresentationController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.05.2023.
//

import UIKit

final class PresentationController: UIPresentationController {
    // MARK: State
    
    private let blurEffectView: UIVisualEffectView
    private var tapGestureRecognizer = UITapGestureRecognizer()
  
    // MARK: Init
    
    override init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
  
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(
            origin: CGPoint(
                x: 0,
                y: (self.containerView?.frame.height ?? 0) * 0.4
            ),
            size: CGSize(
                width: self.containerView?.frame.width ?? 0,
                height: (self.containerView?.frame.height ?? 0) * 0.6
            )
        )
    }

    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { _ in
                self.blurEffectView.alpha = 0.7
            },
            completion: { _ in }
        )
    }
  
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { _ in
                self.blurEffectView.alpha = 0
            },
            completion: { _ in
                self.blurEffectView.removeFromSuperview()
            }
        )
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.roundCorners([.topLeft, .topRight], radius: 22)
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView?.bounds ?? CGRect(origin: .zero, size: .zero)
    }

    @objc func dismissController() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(
                width: radius,
                height: radius
            )
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

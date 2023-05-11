//
//  TinkoffExpressViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 06.05.2023.
//

import UIKit
import Reachability

final class TinkoffExpressViewController: UIViewController {
    let reachability = try? Reachability()
    private lazy var noInternetView = NoInternetView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        reachability?.whenUnreachable = { [weak self]  _ in
            guard let self else { return }
            self.setupWhenUnreachable()
        }
        
        reachability?.whenReachable = { [weak self]  _ in
            guard let self else { return }
            self.animatedHidingView()
        }
        
        try? reachability?.startNotifier()
    }
    
    private func setupWhenUnreachable() {
        view.addSubview(noInternetView)
        
        noInternetView.translatesAutoresizingMaskIntoConstraints = false
        noInternetView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.equalTo(181)
            $0.height.equalTo(50)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.animatedHidingView()
        }
        noInternetView.onViewDidSwipeUP { [weak self] in
            self?.animatedHidingView()
        }
    }
    
    private func animatedHidingView() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self else { return }
            if let superview = noInternetView.superview {
                self.noInternetView.center.y -= superview.bounds.height
            }
        }
    }
}

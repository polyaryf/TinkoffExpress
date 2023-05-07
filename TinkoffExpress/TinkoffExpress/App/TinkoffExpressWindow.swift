//
//  TinkoffExpressWindow.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 06.05.2023.
//

import UIKit
import Reachability

final class TinkoffExpressWindow: UIWindow {
    let reachability = try? Reachability()
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        
        reachability?.whenUnreachable = { _ in
            
        }
        
        try? reachability?.startNotifier()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  RatingAssembly.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.05.2023.
//

import UIKit

protocol IRatingAssembly {
    func createRatingView() -> UIViewController
}

final class RatingAssembly: IRatingAssembly {
    func createRatingView() -> UIViewController {
        let view = RatingViewController()
        return view
    }
}

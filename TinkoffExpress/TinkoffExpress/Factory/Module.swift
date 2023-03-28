//
//  Module.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit

protocol Module {
    static func createViewController(coordinator: AppCoordinator) -> UIViewController
}

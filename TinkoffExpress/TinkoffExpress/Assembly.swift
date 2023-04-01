//
//  Assembly.swift
//  TinkoffExpress
//
//  Created by zedsbook on 01.04.2023.
//

import UIKit

protocol Assembly {
    func createViewController(coordinator: Coordinator) -> UIViewController
}

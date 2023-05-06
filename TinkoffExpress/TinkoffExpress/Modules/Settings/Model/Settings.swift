//
//  Settings.swift
//  TinkoffExpress
//
//  Created by zedsbook on 06.05.2023.
//

import Foundation

struct Settings {
    let text: String
    let description: String
    let imageName: String
    let isActive: Bool
}

enum Search: String {
    case standard = "Стандартный"
    case detailed = "Подробный"
}

enum Localization: String {
    case ru_RU = "Русская"
    case en_US = "Английская"
}

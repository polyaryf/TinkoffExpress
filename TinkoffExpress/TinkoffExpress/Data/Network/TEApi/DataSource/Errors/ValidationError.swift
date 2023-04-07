//
//  ValidationError.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

import Foundation

struct ValidationError: Codable {
    let location: String
    let message: String
    let type: String
}

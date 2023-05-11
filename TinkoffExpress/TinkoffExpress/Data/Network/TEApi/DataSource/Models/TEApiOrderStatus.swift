//
//  TEApiOrderStatus.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.05.2023.
//

import Foundation

enum TEApiOrderStatus: String, Codable {
    case created = "0"
    case inProcessing = "1"
    case delivered = "2"
    case cancelled = "3"
}

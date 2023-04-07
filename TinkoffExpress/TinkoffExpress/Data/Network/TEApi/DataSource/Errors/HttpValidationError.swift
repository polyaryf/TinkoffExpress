//
//  HttpValidationError.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

import Foundation

struct HttpValidationError: Codable {
    var detail: [ValidationError]?
}

//
//  SuggestionResponse.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.04.2023.
//

import Foundation

struct SuggestionResponse: Codable {
    let value: String?
    let unrestrictedValue: String?
    let data: DataResponse
    
    private enum CodingKeys: String, CodingKey {
        case value
        case unrestrictedValue = "unrestricted_value"
        case data
    }
}

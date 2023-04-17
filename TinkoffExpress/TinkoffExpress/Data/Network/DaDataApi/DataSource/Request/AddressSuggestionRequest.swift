//
//  AddressSuggestionRequest.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.04.2023.
//

import Foundation

struct AddressSuggestionRequest: Codable {
    let query: String
    let language: String
}

//
//  AddressInputMapper.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 17.04.2023.
//

import Foundation

final class AddressInputMapper {
    func toInputAddress(from suggestion: SuggestionResponse) -> InputAddress {
        let data = suggestion.data
        
        guard let street = data.street else {
            return InputAddress(
                firstLine: suggestion.value ?? "",
                wholeAddress: changeString(string: suggestion.unrestrictedValue)
            )
        }
        guard let house = data.house else {
            return InputAddress(
                firstLine: street,
                wholeAddress: suggestion.value ?? ""
            )
        }
        return InputAddress(
            firstLine: street + ", \(house)",
            wholeAddress: suggestion.value ?? ""
        )
    }
    
    private func changeString(string: String?) -> String {
        guard let string = string else {
            return ""
        }
        return string.components(separatedBy: " ").dropFirst().joined(separator: " ")
    }
}

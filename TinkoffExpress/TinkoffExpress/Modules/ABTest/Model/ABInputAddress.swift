//
//  ABInputAddress.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 30.04.2023.
//

import Foundation

struct ABInputAddress {
    var country: String
    var region: String
    var street: String
    var house: String
    var settlement: String
    var postalСode: String
}

extension ABInputAddress {
    var stringRepresentation: String {
        var result = ""
        if !self.country.isEmpty {
            result += "\(self.country) "
        }
        if !self.region.isEmpty {
            result += "\(self.region) "
        }
        if !self.street.isEmpty {
            result += "\(self.street) "
        }
        if !self.house.isEmpty {
            result += "\(self.house) "
        }
        if !self.settlement.isEmpty {
            result += "\(self.settlement) "
        }
        if !self.postalСode.isEmpty {
            result += "\(self.postalСode) "
        }
        return result
    }
}

//
//  ABTestHelper.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 02.05.2023.
//

import Foundation

final class ABTestHelper {
    func toString(from abAddress: ABInputAddress) -> String {
        var result = ""
        if !abAddress.country.isEmpty {
            result += "\(abAddress.country) "
        }
        if !abAddress.region.isEmpty {
            result += "\(abAddress.region) "
        }
        if !abAddress.street.isEmpty {
            result += "\(abAddress.street) "
        }
        if !abAddress.house.isEmpty {
            result += "\(abAddress.house) "
        }
        if !abAddress.settlement.isEmpty {
            result += "\(abAddress.settlement) "
        }
        if !abAddress.postalСode.isEmpty {
            result += "\(abAddress.postalСode) "
        }
        return result
    }
}

//
//  AddressSearchRequest.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 05.04.2023.
//

import Foundation

struct AddressSearchRequest: Codable {
    let address: String?
    let lat: Float?
    let lon: Float?
    
    private enum CodingKeys: String, CodingKey {
        case address = "point"
        case lat
        case lon
    }
}

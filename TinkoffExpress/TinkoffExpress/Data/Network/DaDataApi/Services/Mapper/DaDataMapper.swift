//
//  DaDataMapper.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.04.2023.
//

import Foundation

final class DaDataMapper {
    func toDaDataAddress(from suggestionResponse: SuggestionResponse) -> DaDataAddress {
        let data = suggestionResponse.data
        let addressСomponents: [AddressСomponent: String?] = [
            AddressСomponent.country: data.country,
            AddressСomponent.region: data.region,
            AddressСomponent.city: data.city,
            AddressСomponent.street: data.street,
            AddressСomponent.house: data.house,
            AddressСomponent.flat: data.flat,
            AddressСomponent.geoLat: data.geoLat,
            AddressСomponent.geoLon: data.geoLon
        ]
        return DaDataAddress(
            oneLineAddress: suggestionResponse.value,
            addressСomponents: addressСomponents)
    }
}

enum AddressСomponent {
    case country
    case region
    case city
    case street
    case house
    case flat
    case geoLat
    case geoLon
}

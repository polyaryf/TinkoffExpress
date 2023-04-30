//
//  DataResponse.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.04.2023.
//

import Foundation

struct DataResponse: Codable {
    let country: String?
    let region: String?
    let city: String?
    let street: String?
    let house: String?
    let flat: String?
    let geoLat: String?
    let geoLon: String?
    
    private enum CodingKeys: String, CodingKey {
        case country = "country"
        case region = "region_with_type"
        case city = "city_with_type"
        case street = "street_with_type"
        case house = "house"
        case flat = "flat_with_type"
        case geoLat = "geo_lat"
        case geoLon = "geo_lon"
    }
}

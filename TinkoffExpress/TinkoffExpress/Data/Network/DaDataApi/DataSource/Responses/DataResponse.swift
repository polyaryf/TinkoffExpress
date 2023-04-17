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
        case country = "data.country"
        case region = "data.region"
        case city = "data.city"
        case street = "data.street"
        case house = "data.house"
        case flat = "data.flat"
        case geoLat = "data.geo_lat"
        case geoLon = "data.geo_lon"
    }
}

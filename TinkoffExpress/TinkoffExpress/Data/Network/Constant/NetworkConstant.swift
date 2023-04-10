//
//  NetworkConstant.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.04.2023.
//

import Foundation

// swiftlint:disable all
enum NetworkConstant {
    static let baseTEApiURL = URL(string: "http://185.204.0.180:8000")!
    static let baseDaDataApiURL = URL(string: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address")!
    static let daDataApiKey = "5706dfdc27eb513ba142289d4cb22efc6e7ea9ec"
}

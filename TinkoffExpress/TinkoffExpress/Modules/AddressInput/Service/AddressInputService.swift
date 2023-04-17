//
//  AddressInputService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 17.04.2023.
//

import Foundation

protocol AddressInputService {
    func loadAddresses(
        with text: String,
        completion: @escaping (Result<[InputAddress], Error>) -> Void
    )
}

final class MockAddressInputService: AddressInputService {
    let mockAddresses1: [InputAddress] = [
        .init(
            street: "ул. Новотушинская, 1",
            wholeAddress: "Московская обл., г. Красногорск, деревня Путилково, ул. Новотушинская, 1"
        )
    ]
    let mockAddresses2: [InputAddress] = [
        .init(
            street: "ул. Кремлевская, 1",
            wholeAddress: "Респ. Татарстан., г. Казань, ул. Кремлевская, 1"
        )
    ]
    
    func loadAddresses(
        with text: String,
        completion: @escaping (Result<[InputAddress], Error>) -> Void
    ) {
        if !text.isEmpty {
            completion(.success(mockAddresses1))
        } else if text.isEmpty {
            completion(.success(mockAddresses2))
        }
    }
}

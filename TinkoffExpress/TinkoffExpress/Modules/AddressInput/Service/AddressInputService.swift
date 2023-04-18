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

final class RestAddressInputService: AddressInputService {
    // MARK: Dependency
    private let networkService: DaDataApiService
    private let mapper: AddressInputMapper
    
    // MARK: Init
    
    init(networkService: DaDataApiService, mapper: AddressInputMapper) {
        self.networkService = networkService
        self.mapper = mapper
    }
    
    func loadAddresses(with text: String, completion: @escaping (Result<[InputAddress], Error>) -> Void) {
        networkService.getAddresses(
            request: AddressSuggestionRequest(query: text, language: "")
        ) { [ weak self] result in
            let newResult = result.map { suggestionsResponse in
                suggestionsResponse.suggestions.compactMap { suggestion in
                    self?.mapper.toInputAddress(from: suggestion)
                }
            }
            .mapError { $0 as Error }
            
            completion(newResult)
        }
    }
}

final class MockAddressInputService: AddressInputService {
    let mockAddresses: [InputAddress] = [
        .init(
            firstLine: "ул. Новотушинская, 1",
            wholeAddress: "Московская обл., г. Красногорск, деревня Путилково, ул. Новотушинская, 1"
        ),
        .init(
            firstLine: "ул. Новотушинская, 1",
            wholeAddress: "Московская обл., г. Красногорск, деревня Путилково, ул. Новотушинская, 1"
        ),
        .init(
            firstLine: "ул. Новотушинская, 1",
            wholeAddress: "Московская обл., г. Красногорск, деревня Путилково, ул. Новотушинская, 1"
        )
    ]
    
    func loadAddresses(
        with text: String,
        completion: @escaping (Result<[InputAddress], Error>) -> Void
    ) {
        completion(.success(mockAddresses))
    }
}

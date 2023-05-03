//
//  ABTestService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 02.05.2023.
//

import Foundation

protocol ABTestService {
    func loadAddress(
        with text: String,
        completion: @escaping (Result<String, Error>) -> Void
    )
}

final class RestABTestService: ABTestService {
    // MARK: Dependency
    
    private let networkService: DaDataApiService

    // MARK: Init
    
    init(
        networkService: DaDataApiService
    ) {
        self.networkService = networkService
    }
    
    // MARK: ABTestService
    
    func loadAddress(
        with text: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        networkService.getAddresses(
            request: AddressSuggestionRequest(query: text, language: "")
        ) { result in
            let newResult = result.map { suggestionsResponse in
                guard let address = suggestionsResponse.suggestions.first?.value else {
                    return ""
                }
                return address
            }
            .mapError { $0 as Error }
            
            completion(newResult)
        }
    }
}

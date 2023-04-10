//
//  DaDataAddressesProtocol.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.04.2023.
//

protocol DaDataAddressesProtocol {
    func getAddresses(
        request: AddressSuggestionRequest,
        completion: @escaping (Result<SuggestionsResponse, HttpClientError>) -> Void
    )
}

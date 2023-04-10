//
//  DaDataApiService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.04.2023.
//

class DaDataApiService: DaDataAddressesProtocol {
    private let service = GenericService<DaDataApiTargetType>()
    
    func getAddresses(
        request: AddressSuggestionRequest,
        completion: @escaping (Result<SuggestionsResponse, HttpClientError>) -> Void
    ) {
        service.performAndDecode(
            target: .getAddress(request: request),
            completion: completion
        )
    }
}

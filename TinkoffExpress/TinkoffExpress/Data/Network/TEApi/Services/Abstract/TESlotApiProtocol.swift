//
//  TESlotApiProtocol.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 06.04.2023.
//

protocol TESlotApiProtocol {
    func getSlots(
        completion: @escaping (Result<[TimeSlot], HttpClientError>) -> Void
    )
}

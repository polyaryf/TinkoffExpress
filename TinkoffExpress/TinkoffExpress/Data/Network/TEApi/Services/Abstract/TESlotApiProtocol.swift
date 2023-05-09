//
//  TESlotApiProtocol.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 06.04.2023.
//

protocol TESlotApiProtocol {
    func getSlots(
        forDate date: String,
        completion: @escaping (Result<[TEApiTimeSlot], HttpClientError>) -> Void
    )
}

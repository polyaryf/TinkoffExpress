//
//  IMeetingAppointmentService.swift
//  TinkoffExpress
//
//  Created by zedsbook on 03.04.2023.
//

import Foundation

protocol IMeetingAppointmentService {
    func loadSlots(forDate date: Date, completion: @escaping (Result<[TEApiTimeSlot], Error>) -> Void)
    func updateOrder(
        id: Int,
        with request: OrderUpdateRequest,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}

final class MeetingAppointmentService: IMeetingAppointmentService {
    // MARK: Dependencies
    
    private let api: TEApiService
    private let dateFormatter: DateFormatter
    
    // MARK: Init
    
    init(
        api: TEApiService,
        dateFormatter: DateFormatter = .default
    ) {
        self.api = api
        self.dateFormatter = dateFormatter
    }
    
    // MARK: IMeetingAppointmentService
    
    func loadSlots(forDate date: Date, completion: @escaping (Result<[TEApiTimeSlot], Error>) -> Void) {
        api.getSlots(forDate: dateFormatter.string(from: date)) { result in
            completion(result.mapError { $0 as Error })
        }
    }
    
    func updateOrder(
        id: Int,
        with request: OrderUpdateRequest,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        api.updateOrder(request: request, orderId: id) { result in
            let newResult = result.mapError { $0 as Error }
            completion(newResult)
        }
    }
}

private extension DateFormatter {
    static var `default`: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}

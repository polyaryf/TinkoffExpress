//
//  TEApiService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.04.2023.
//

class TEApiService: TEOrderApiProtocol, TESlotApiProtocol {
    private let service = GenericService<TEApiTargetType>()
    
    func test(
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        service.perform(
            target: .test,
            completion: completion
        )
    }
    
    func getOrders(
        completion: @escaping (Result<[TEApiOrder], HttpClientError>) -> Void
    ) {
        service.performAndDecode(
            target: .getOrders,
            completion: { (result: Result<GetOrdersResponce, HttpClientError>) in
                let newResult = result.map { responce in
                    responce.orders
                }
                completion(newResult)
            }
        )
    }
    
    func createOrder(
        reqest: OrderCreateRequest,
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        service.perform(
            target: .createOrder(request: reqest),
            completion: completion
        )
    }
    
    func updateOrder(
        request: OrderUpdateRequest,
        orderId: Int,
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        service.perform(
            target: .updateOrder(request: request, orderId: orderId),
            completion: completion
        )
    }
    
    func getSlots(
        forDate date: String,
        completion: @escaping (Result<[TEApiTimeSlot], HttpClientError>) -> Void
    ) {
        service.performAndDecode(
            target: .getSlots(date: date),
            completion: completion
        )
    }
}

struct GetOrdersResponce: Decodable {
    let orders: [TEApiOrder]
    
    enum CodingKeys: CodingKey {
        case orders
    }
    
    init(from decoder: Decoder) throws {
        orders = try Array<SafeDecodable<TEApiOrder>>(from: decoder)
            .compactMap { order in
                try? order.decodingResult.get()
        }
    }
}

struct SafeDecodable<T: Decodable>: Decodable {
    let decodingResult: Result<T, Error>
    
    init(from decoder: Decoder) throws {
        self.decodingResult = Result(catching: {
            try T.init(from: decoder)
        })
    }
}

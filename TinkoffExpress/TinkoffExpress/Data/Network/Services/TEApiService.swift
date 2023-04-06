//
//  TEApiService.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 05.04.2023.
//

import Moya

var TEApiProvider = MoyaProvider<TEApiService>(
    plugins: [
        TEMoyaLogger()
    ]
)

enum TEApiService {
    case test
    case getOrders
    case createOrder(request: OrderCreateRequest)
    case updateOrder(request: OrderUpdateRequest, orderId: Int)
    case getAddresses
    case searchAddresses(request: AddressSearchRequest)
    case getSlots
}

extension TEApiService: TargetType {
    var baseURL: URL {
        URL(string: "http://185.204.0.180:8000")!
    }
    
    var path: String {
        switch self {
        case .test:
            return "/"
        case .getOrders:
            return "/oreders"
        case .createOrder:
            return "/orders"
        case .updateOrder(_, let id):
            return "/orders/\(id)"
        case .getAddresses:
            return "/addresses/search"
        case .searchAddresses:
            return "/addresses/my"
        case .getSlots:
            return "/slots"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .test:
            return .get
        case .getOrders:
            return .get
        case .createOrder:
            return .post
        case .updateOrder:
            return .put
        case .getAddresses:
            return .get
        case .searchAddresses:
            return .get
        case .getSlots:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .test:
            return .requestPlain
        case .getOrders:
            return .requestPlain
        case .createOrder(let request):
            return .requestParameters(
                parameters: [
                    "point": request.address,
                    "payment_method": request.paymentMethod,
                    "delivery_slot": request.deliverySlot,
                    "items": request.items,
                    "comment": request.comment,
                    "status": request.status
                ],
                encoding: JSONEncoding.default
            )
        case .updateOrder(let request, _):
            return .requestParameters(
                parameters: [
                    "point": request.address,
                    "payment_method": request.paymentMethod,
                    "delivery_slot": request.deliverySlot,
                    "comment": request.comment,
                    "status": request.status
                ],
                encoding: JSONEncoding.default
            )
        case .getAddresses:
            return .requestPlain
        case .searchAddresses(let request):
            return .requestParameters(
                parameters: [
                    "address": request.address,
                    "lat": request.lat,
                    "lon": request.lon
                ],
                encoding: JSONEncoding.default
            )
        case .getSlots:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

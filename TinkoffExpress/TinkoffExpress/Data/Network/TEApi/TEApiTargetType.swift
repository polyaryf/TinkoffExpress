//
//  TEApiTargetType.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 05.04.2023.
//

import Moya

enum TEApiTargetType {
    case test
    case getOrders
    case createOrder(request: OrderCreateRequest)
    case updateOrder(request: OrderUpdateRequest, orderId: Int)
    case getSlots(date: String)
}

extension TEApiTargetType: TargetType {
    var baseURL: URL {
        NetworkConstant.baseTEApiURL
    }
    
    var path: String {
        switch self {
        case .test:
            return "/"
        case .getOrders:
            return "/orders"
        case .createOrder:
            return "/orders"
        case .updateOrder(_, let id):
            return "/orders/\(id)"
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
            return .requestJSONEncodable(request)
        case .updateOrder(let request, _):
            return .requestJSONEncodable(request)
        case let .getSlots(date):
            return .requestParameters(parameters: ["d": date], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

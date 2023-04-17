//
//  DaDataApiTargetType.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.04.2023.
//

import Moya

enum DaDataApiTargetType {
    case getAddress(request: AddressSuggestionRequest)
}

extension DaDataApiTargetType: TargetType {
    var baseURL: URL {
        NetworkConstant.baseDaDataApiURL
    }
    
    var path: String {
        switch self {
        case .getAddress:
            return "/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAddress:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAddress(let requst):
            return .requestJSONEncodable(requst)
        }
    }
    
    var headers: [String: String ]? {
        return [
            "Content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Token \(NetworkConstant.daDataApiKey)"
        ]
    }
}

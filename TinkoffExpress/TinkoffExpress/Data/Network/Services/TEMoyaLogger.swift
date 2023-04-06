//
//  TEMoyaLogger.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 05.04.2023.
//

import Moya

class TEMoyaLogger: PluginType {
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        if case let .success(success) = result {
            if let response = success.response, let request = success.request {
                log(
                    request: request,
                    response: response,
                    responseBody: success.data
                )
            }
        }
    }

    func log(
        request: URLRequest,
        response: HTTPURLResponse,
        responseBody: Data
    ) {
        let path: String = request.url?.path ?? ""
        let query: String = request.url?.query ?? ""
        let method: String = request.method?.rawValue ?? ""
        print("\n")
        switch response.statusCode {
        case 200 ..< 300:
            if query.isEmpty {
                print("✅ \(method) \(path)")
            } else {
                print("✅ \(method) \(path)?\(query)")
            }
        default:
            print("❌ \(method) \(path) failed")
        }
        if let headers = request.allHTTPHeaderFields, headers.isEmpty == false {
            print("----------")
            print("Request headers:")
            print("{")
            headers.forEach { key, value in
                print("\t\(key): \(value)")
            }
            print("}")
        }
        if let body = request.httpBody {
            print("----------")
            print("Request body:")
            print(String(data: body, encoding: .utf8) ?? "")
        }
        if let headers = response.allHeaderFields as? [String: String],
        headers.isEmpty == false {
            print("----------")
            print("Response headers:")
            print("{")
            headers.forEach { key, value in
                print("\t\(key): \(value)")
            }
            print("}")
        }
        print("----------")
        print("Response: \(response.statusCode)")
        if responseBody.isEmpty == false {
            print(String(data: responseBody, encoding: .utf8) ?? "")
        }
        print("\n")
    }
}

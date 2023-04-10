//
//  HttpClientError.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.04.2023.
//

import Alamofire
import Foundation
import Moya

public class HttpClientError: NSError {
    public enum HttpClientErrorType {
        case unknown
        case requestError // 400..<500 except 401
        case serverError // 500+
        case parsingError // Decoding error
        case noInternet
        case connectionError // URLSession error

        public var errorDescription: String? {
            switch self {
            case .serverError:
                return "remoteError"
            case .requestError:
                return "requestError"
            case .unknown:
                return "unknownError"
            case .connectionError:
                return "Update in progress"
            case .parsingError:
                return nil
            case .noInternet:
                return "noInternet"
            }
        }
    }

    public var type: HttpClientErrorType = .unknown
    public var httpStatusCode: Int?

    public init(
        type: HttpClientErrorType,
        httpStatusCode: Int?,
        localizedDescription: String?
    ) {
        self.type = type
        self.httpStatusCode = httpStatusCode
        super.init(
            domain: "Pumpt",
            code: httpStatusCode ?? 0,
            userInfo: [
                NSLocalizedDescriptionKey: type.errorDescription ?? "unknownError"
            ]
        )
    }

    public init(withError error: Error) {
        self.httpStatusCode = nil
        if error is MoyaError {
            if NetworkReachabilityManager.default?.status == .notReachable {
                self.type = .noInternet
            } else {
                self.type = .connectionError
            }
        }
        super.init(
            domain: "Pumpt",
            code: (error as NSError).code,
            userInfo: [
                NSLocalizedDescriptionKey: type.errorDescription ?? error.localizedDescription
            ]
        )
    }

    public init?(
        httpStatus: Int, responseData: Data
    ) {
        let httpErrorType: HttpClientError.HttpClientErrorType
        let errorDescription: String?
        switch httpStatus {
        case 400, 402 ..< 500:
            httpErrorType = .requestError
            errorDescription = ErrorDto.getErrorFromData(responseData)
                ?? httpErrorType.errorDescription
        case 500 ..< 700:
            httpErrorType = .serverError
            errorDescription = ErrorDto.getErrorFromData(responseData)
                ?? httpErrorType.errorDescription
        default:
            return nil
        }
        self.type = httpErrorType
        self.httpStatusCode = httpStatus
        super.init(
            domain: "Pumpt",
            code: httpStatusCode ?? 0,
            userInfo: [
                NSLocalizedDescriptionKey: errorDescription ?? "unknownError"
            ]
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private struct ErrorDto: Decodable {
    let error: String

    static func getErrorFromData(_ responseData: Data) -> String? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let errorDto: ErrorDto? = try? decoder.decode(
            ErrorDto.self, from: responseData
        )
        return errorDto?.error
    }
}

//
//  NetworkManager.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.04.2023.
//

import Moya
import Alamofire

class GenericService<T: TargetType> {
    private lazy var session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        return Session(
            configuration: configuration,
            startRequestsImmediately: false
        )
    }()
    
    public lazy var dataProvider: MoyaProvider<T> = MoyaProvider<T>(
        session: session,
        plugins: [TEMoyaLogger()]
    )
    
    public init() {}
    
    // swiftlint:disable:next function_body_length
    public func performAndDecode<R: Decodable>(
        target: T,
        completion: @escaping (Result<R, HttpClientError>) -> Void
    ) {
        self.dataProvider.request(target) { result in
            switch result {
            case let .success(moyaResponse):
                if let error = HttpClientError(
                    httpStatus: moyaResponse.statusCode,
                    responseData: moyaResponse.data
                ) {
                    completion(.failure(error))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(
                        R.self,
                        from: moyaResponse.data
                    )
                    completion(.success(response))
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                    let httpError = HttpClientError(
                        type: .parsingError,
                        httpStatusCode: nil,
                        localizedDescription: "Data corrupted"
                    )
                    completion(.failure(httpError))
                    return
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    let httpError = HttpClientError(
                        type: .parsingError,
                        httpStatusCode: nil,
                        localizedDescription: "Data decoding error."
                    )
                    completion(.failure(httpError))
                    return
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    let httpError = HttpClientError(
                        type: .parsingError,
                        httpStatusCode: nil,
                        localizedDescription: "Data decoding error."
                    )
                    completion(.failure(httpError))
                    return
                } catch let DecodingError.typeMismatch(type, context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    let httpError = HttpClientError(
                        type: .parsingError,
                        httpStatusCode: nil,
                        localizedDescription: "Data decoding error."
                    )
                    completion(.failure(httpError))
                    return
                } catch {
                    print("error: ", error)
                    let httpError = HttpClientError(
                        type: .parsingError,
                        httpStatusCode: nil,
                        localizedDescription: error.localizedDescription
                    )
                    completion(.failure(httpError))
                    return
                }
            case let .failure(error):
                completion(.failure(HttpClientError(withError: error)))
            }
        }
    }
    
    public func perform(
        target: T,
        completion: @escaping (Result<Bool, HttpClientError>) -> Void
    ) {
        dataProvider.request(target) { result in
            switch result {
            case let .success(moyaResponse):
                if let error = HttpClientError(
                    httpStatus: moyaResponse.statusCode,
                    responseData: moyaResponse.data
                ) {
                    completion(.failure(error))
                    return
                }
                completion(.success(true))
            case let .failure(error):
                completion(.failure(HttpClientError(withError: error)))
            }
        }
    }
}

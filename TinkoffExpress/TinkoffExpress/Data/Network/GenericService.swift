//
//  NetworkManager.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 07.04.2023.
//

import Moya
import Alamofire
import Combine

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
    
    public func performAndDecode<R: Decodable>(
        target: T
    ) -> Future<R, HttpClientError> {
        return Future<R, HttpClientError> { [weak self] promise in
            self?.dataProvider.request(target) { result in
                switch result {
                case let .success(moyaResponse):
                    if let error = HttpClientError(
                        httpStatus: moyaResponse.statusCode,
                        responseData: moyaResponse.data
                    ) {
                        promise(.failure(error))
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(
                            R.self,
                            from: moyaResponse.data
                        )
                        promise(.success(response))
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                        let httpError = HttpClientError(
                            type: .parsingError,
                            httpStatusCode: nil,
                            localizedDescription: "Data corrupted"
                        )
                        promise(.failure(httpError))
                        return
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        let httpError = HttpClientError(
                            type: .parsingError,
                            httpStatusCode: nil,
                            localizedDescription: "Data decoding error."
                        )
                        promise(.failure(httpError))
                        return
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        let httpError = HttpClientError(
                            type: .parsingError,
                            httpStatusCode: nil,
                            localizedDescription: "Data decoding error."
                        )
                        promise(.failure(httpError))
                        return
                    } catch let DecodingError.typeMismatch(type, context) {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                        let httpError = HttpClientError(
                            type: .parsingError,
                            httpStatusCode: nil,
                            localizedDescription: "Data decoding error."
                        )
                        promise(.failure(httpError))
                        return
                    } catch {
                        print("error: ", error)
                        let httpError = HttpClientError(
                            type: .parsingError,
                            httpStatusCode: nil,
                            localizedDescription: error.localizedDescription
                        )
                        promise(.failure(httpError))
                        return
                    }
                case let .failure(error):
                    promise(.failure(HttpClientError(withError: error)))
                }
            }
        }
    }
        
    public func perform(
        target: T
    ) -> Future<Bool, HttpClientError> {
        return Future<Bool, HttpClientError> { [weak self] promise in
            self?.dataProvider.request(target) { result in
                switch result {
                case let .success(moyaResponse):
                    if let error = HttpClientError(
                        httpStatus: moyaResponse.statusCode,
                        responseData: moyaResponse.data
                    ) {
                        promise(.failure(error))
                        return
                    }
                    promise(.success(true))
                case let .failure(error):
                    promise(.failure(HttpClientError(withError: error)))
                }
            }
        }
    }
}

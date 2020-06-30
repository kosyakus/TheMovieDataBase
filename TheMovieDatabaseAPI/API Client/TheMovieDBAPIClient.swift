//
//  TheMovieDBAPIClient.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 21.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

public final class TheMovieDBAPIClient {
    
    /// Менеджер сетевой сессии.
    private let sessionManager: Alamofire.SessionManager
    
    /// Адаптер для запросов.
    private let requestAdapter: APIRequestAdapter

    public init(baseURL: URL,
                apiKey: String,
                configuration: URLSessionConfiguration,
                sessionId: String? = nil) {
        self.requestAdapter = APIRequestAdapter(baseURL: baseURL, apiKey: apiKey, sessionId: sessionId)
        self.sessionManager = SessionManager(configuration: configuration)
        self.sessionManager.adapter = requestAdapter
        // Удалить Cookies
        self.sessionManager.session.configuration.httpCookieAcceptPolicy = .never
    }
    
    /// Отправить запрос к API.
    ///
    /// - Parameters:
    ///   - endpoint: Конечная точка запроса.
    ///   - completionHandler: Обработчик результата запроса.
    /// - Returns: Прогресс выполнения запроса.
    public func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (Swift.Result<T.Content, Error>) -> Void) -> Progress where T: Endpoint {

        let anyRequest = AnyRequest(create: endpoint.makeRequest)
        let request = sessionManager.request(anyRequest).responseData { (response: DataResponse<Data>) in
            switch response.result {
            case .success(let data):
                do {
                    let content = try endpoint.content(from: data, response: response.response)
                    completionHandler(.success(content))
                } catch let error {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        return request.progress
    }
    
    private struct AnyRequest: Alamofire.URLRequestConvertible {
        let create: () throws -> URLRequest

        func asURLRequest() throws -> URLRequest {
            try create()
        }
    }
}

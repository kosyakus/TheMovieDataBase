//
//  LoginService.swift
//  TheMovieDatabase
//
//  Created by Natali on 27.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

/// Сервис работы с избранным.
protocol LoginServices {
    
    /// Загрузка избранных фильмов.
    ///
    /// - Parameters:
    ///   - completionHandler: Обработчик результата входа.
    /// - Returns: Прогресс выполнения входа.
    @discardableResult
    func fetchToken(login: String,
                    password: String,
                    completion: @escaping (Token) -> Void) -> Progress
    func validateToken(login: String,
                       password: String,
                       requestToken: String,
                       completion: @escaping (Result<Bool, Error>) -> Void) -> Progress
    func createSession(requestToken: String,
                       completion: @escaping (Result<Session, Error>) -> Void) -> Progress
}

final public class LoginServicesImplementation: LoginServices {
    
    private let client: TheMovieDBAPIClient
    
    public init(client: TheMovieDBAPIClient) {
        self.client = client
    }
    
    /// Функция получения токена
    @discardableResult
    func fetchToken(login: String, password: String, completion: @escaping (Token) -> Void) -> Progress {
        
        client.request(TokenEndpoint()) { result in
            switch result {
            case .success(let token):
                self.thenValidateToken(login: login, password: password, requestToken: token.requestToken) {
                    let token = Token(token: token.requestToken)
                    completion(token)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// Валидация токена при помощи логина и пароля
    func validateToken(login: String,
                       password: String,
                       requestToken: String,
                       completion: @escaping (Result<Bool, Error>) -> Void) -> Progress {
        
        client.request(ValidateTokenEndpoint(login: login, password: password, token: requestToken)) { _ in
            completion(.success(true))
        }
    }
    
    /// Срздание сессии
    func createSession(requestToken: String, completion: @escaping (Result<Session, Error>) -> Void) -> Progress {
        client.request(CreateSessionEndpoint(token: requestToken)) { result in
            let sessionResult = result.flatMap { session -> Result<Session, Error> in
                let session = Session(sessionID: session.sessionId)
                return .success(session)
            }
            completion(sessionResult)
        }
    }
    
    /// Вспомогательная функция валидирования токена после успешного получения токена
    private func thenValidateToken(login: String,
                                   password: String,
                                   requestToken: String,
                                   completion: @escaping () -> Void) {
        validateToken(login: login, password: password, requestToken: requestToken) { result in
            switch result {
            case .success:
                self.thenCreateSession(login: login, requestToken: requestToken) {
                    completion()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// Вспомогательная функция получения сессии после успешной валидации
    private func thenCreateSession(login: String, requestToken: String, completion: @escaping () -> Void) {
        createSession(requestToken: requestToken) { result in
            switch result {
            case .success(let session):
                try? ManageKeychain().saveSessionId(sessionId: session.sessionID,
                                                    user: KeychainUser(username: login))
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

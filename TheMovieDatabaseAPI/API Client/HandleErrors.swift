//
//  HandleErrors.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 13.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

final class HandleErrors {
    
    enum NetworkResponse: String {
        case success
        case authenticationError = "Необходимо зарегистрироваться."
        case badRequest = "Bad request."
        case outdated = "The url you requested is outdated."
        case failed = "Network request failed."
        case noData = "Response returned with no data to decode."
        case unableToDecode = "We could not decode the response."
    }
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}

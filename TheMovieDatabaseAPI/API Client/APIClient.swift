//
//  APIClient.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 14.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

// https://medium.com/@AladinWay/write-a-networking-layer-in-swift-4-using-alamofire-and-codable-part-1-api-router-349699a47569

import Alamofire
import Foundation

public typealias APIResult<T> = Result<T, Error>

class APIClient {
    
    @discardableResult
    static func performRequest<T: Decodable> (route: URLRequestConvertible,
                                              decoder: JSONDecoder = JSONDecoder(),
                                              completion: @escaping (AFResult<T>) -> Void) -> DataRequest {
        let dataRequest = AF.request(route).responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
            completion(response.result)
        }
        dataRequest.validate()
        return dataRequest
    }
}

//protocol APIClient: AnyObject {
//
//    @discardableResult
//    static func performRequest<T: Decodable> (route: URLRequestConvertible,
//                                              completion: @escaping (AFResult<T>) -> Void) -> Progress where T: Endpoint
//}
//
//class APIClientMovie: APIClient {
//
//    private func configure(_ request: URLRequest) -> URLRequest {
//        var urlRequest = request
//        urlRequest.url = URL(string: "")
//        return urlRequest
//    }
//
//    @discardableResult
//    static func performRequest<T: Decodable> (route: URLRequestConvertible,
//                                              completion: @escaping (AFResult<T>) -> Void) -> Progress where T: Endpoint {
//        let dataRequest = Request(route) { response in //(route).responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
//            completion(response.result)
//        }
//        dataRequest.validate()
//        return dataRequest
//    }
//}

//public protocol APIClient {
//
//    @discardableResult
//    static func request<T> (_ endpoint: T,
//                            completion: @escaping (APIResult<T>) -> Void) -> Progress where T: Endpoint
//}

// class APIClient {
//
//     @discardableResult
//     static func performRequest<T: Decodable> (route: URLRequestConvertible,
//                                               decoder: JSONDecoder = JSONDecoder(),
//                                               completion: @escaping (AFResult<T>) -> Void) -> DataRequest {
//         let dataRequest = AF.request(route).responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
//             completion(response.result)
//         }
//         dataRequest.validate()
//         return dataRequest
//     }
// }


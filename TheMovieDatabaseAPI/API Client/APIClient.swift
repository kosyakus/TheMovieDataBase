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

class APIClient {
    
    @discardableResult
    static func performRequest<T: Decodable> (route: URLRequestConvertible,
                                              decoder: JSONDecoder = JSONDecoder(),
                                              completion: @escaping (AFResult<T>) -> Void) -> DataRequest {
        return AF.request(route)
        .responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
            completion(response.result)
        }
    }
}

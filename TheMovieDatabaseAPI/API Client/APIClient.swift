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
    private static func performRequest<T:Decodable>(route:Router, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                completion(response.result)
        }
    }
    
    
    /*static func login(email: String, password: String, completion:@escaping (AFResult<User>)->Void) {
        performRequest(route: APIRouter.login(email: email, password: password), completion: completion)
    }
    
    static func getArticles(completion:@escaping (Result<[Article]>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: APIRouter.articles, decoder: jsonDecoder, completion: completion)
    }*/
    
    
    
    @discardableResult
    func request<T>(_ endpoint: T, completionHandler: @escaping (AFResult<T.Content>) -> Void) -> Progress where T: Endpoint {
        return AF.request(endpoint)
            .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                completion(response.result)
        }
    }
}

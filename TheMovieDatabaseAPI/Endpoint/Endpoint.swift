//
//  Endpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 14.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    associatedtype Content
    
    func makeRequest() throws -> URLRequest
    
    func content(from data: Data, response: URLResponse?) throws -> Content
}

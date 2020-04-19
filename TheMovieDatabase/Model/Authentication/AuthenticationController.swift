//
//  AuthenticationController.swift
//  TheMovieDatabase
//
//  Created by Natali on 18.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import LocalAuthentication

class AuthenticationController {
    
    func authenticateTapped(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            // Could not evaluate policy
            completion(false)
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in") { success, error in
            
            guard success else {
                // return mistake
                return
            }
            // User authenticated successfully, take some action
            completion(true)
        }
    }
    
}

//
//  ManageKeychain.swift
//  TheMovieDatabase
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

class ManageKeychain {
    
    static let serviceName = "MovieService"
    
    func getSessionID() -> String {
        var sessionId = ""
        guard let currentUser = KeychainSettings.currentUser else { return sessionId }
        do {
        sessionId = try KeychainPasswordItem(service: ManageKeychain.serviceName,
                                             account: currentUser.username).readPassword()
        } catch {
            
        }
        return sessionId
    }
    
    func saveSessionId(sessionId: String, user: KeychainUser) throws {
        try KeychainPasswordItem(service: ManageKeychain.serviceName, account: user.username).savePassword(sessionId)
        KeychainSettings.currentUser = user
        NotificationCenter.default.post(name: .loginStatusChanged, object: nil)
    }
    
    func deleteSessionId() throws {
        guard let currentUser = KeychainSettings.currentUser else { return }
        try KeychainPasswordItem(service: ManageKeychain.serviceName, account: currentUser.username).deleteItem()
        KeychainSettings.currentUser = nil
        NotificationCenter.default.post(name: .loginStatusChanged, object: nil)
    }
    
}

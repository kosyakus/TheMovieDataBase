//
//  LoadAccount.swift
//  TheMovieDatabase
//
//  Created by Natali on 31.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

final class LoadAccount {
    
    let accountService: AccountService = ServiceLayer.shared.accountService
    
    func loadProfile() {
        guard let session = try? ManageKeychain().getSessionID() else { return }
        accountService.fetchUser(session: session) { user in
            guard let id = user.id else { return }
            UserSettings.shareInstance.accountID = "\(id)"
//            print(result)
//            switch result {
//            case .success(let user):
//                UserSettings.shareInstance.accountID = "\(user.id)"
//            case .failure(let error):
//                print(error.localizedDescription)
            //}
        }
    }
    
    func getUerDetails(completion: @escaping (User) -> Void) {
        guard let session = try? ManageKeychain().getSessionID() else { return }
                accountService.fetchUser(session: session) { user in
                    completion(user)
                }
    }
    
}

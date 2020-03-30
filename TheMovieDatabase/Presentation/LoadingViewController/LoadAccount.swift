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
        accountService.fetchUser() { result in
            print(result)
            switch result {
            case .success(let user):
                UserSettings.shareInstance.accountID = "\(user.id)"
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

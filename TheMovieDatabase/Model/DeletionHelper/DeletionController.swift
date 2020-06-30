//
//  DeletionController.swift
//  TheMovieDatabase
//
//  Created by Natali on 20.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseDBLayer

class DeletionController {
    
    func deleteAllData() {
        deleteAllFromDB()
        deleteAllFromKeychain()
        deleteAllFromUserSettings()
    }
    
    /// Удаленеие всех записей из БД
    func deleteAllFromDB() {
        let viewModel = RealmMovieViewModel(with: AnyRepository())
        viewModel.deleteRepository()
        let CDviewModel = CDMovieViewModel(with: CoreDataRepository(persistentContainer:
            CoreDataService.shared.persistentContainer))
        CDviewModel.deleteRepository()
        
        UserSettings.shareInstance.dataBase = 0
    }
    
    /// Удаленеие всех записей из Keychain
    func deleteAllFromKeychain() {
        try? ManageKeychain().deleteSessionId()
        try? ManageKeychain().deletePin()
        try? KeychainSaltItem.delete(key: "salt")
        try? KeychainSaltItem.delete(key: "session")
    }
    
    /// Удаленеие всех записей из UserSettings
    func deleteAllFromUserSettings() {
        UserSettings.shareInstance.accountID = ""
        UserSettings.shareInstance.dataBase = 0
        UserSettings.shareInstance.isPinCreated = false
    }
}

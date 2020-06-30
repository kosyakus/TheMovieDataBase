//
//  KeychainSaltItem.swift
//  TheMovieDatabase
//
//  Created by Natali on 19.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

class KeychainSaltItem {

    class func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecValueData as String: data ] as [String: Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne ] as [String: Any]

        var dataTypeRef: AnyObject?

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    class func delete(key: String) throws {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne ] as [String: Any]

        var dataTypeRef: AnyObject?

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        guard status == noErr else { return }
        SecItemDelete(query as CFDictionary)
    }

    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }
}

//struct KeychainSaltItem {
//
//    // MARK: - Types
//
//    enum KeychainError: Error {
//        case noSalt
//        case unexpectedSaltData
//        case unexpectedItemData
//        case unhandledError(status: OSStatus)
//    }
//
//    // MARK: - Properties
//
//    let service: String
//
//    private(set) var account: String
//
//    let accessGroup: String?
//
//    // MARK: - Intialization
//
//    init(service: String, account: String, accessGroup: String? = nil) {
//        self.service = service
//        self.account = account
//        self.accessGroup = accessGroup
//    }
//
//    // MARK: - Keychain access
//
//    func readSalt() throws -> Data {
//        /*
//         Build a query to find the item that matches the service, account and
//         access group.
//         */
//        var query = KeychainSaltItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
//        query[kSecMatchLimit as String] = kSecMatchLimitOne
//        query[kSecReturnAttributes as String] = kCFBooleanTrue
//        query[kSecReturnData as String] = kCFBooleanTrue
//
//        // Try to fetch the existing keychain item that matches the query.
//        var queryResult: AnyObject?
//        let status = withUnsafeMutablePointer(to: &queryResult) {
//            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
//        }
//
//        // Check the return status and throw an error if appropriate.
//        guard status != errSecItemNotFound else { throw KeychainError.noSalt }
//        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
//
//        // Parse the password string from the query result.
//        guard let existingItem = queryResult as? [String: Data],
//            let saltData = existingItem[kSecValueData as String]
//            //let salt = String(data: saltData, encoding: String.Encoding.utf8)
//            else {
//                throw KeychainError.unexpectedSaltData
//        }
//
//        return saltData
//    }
//
//    func saveSalt(_ salt: Data) throws {
//        // Encode the password into an Data object.
//        //let encodedSalt = salt.data(using: String.Encoding.utf8)!
//
//        do {
//            // Check for an existing item in the keychain.
//            try _ = readSalt()
//
//            // Update the existing item with the new password.
//            var attributesToUpdate = [String: Data]()
//            attributesToUpdate[kSecValueData as String] = salt
//
//            let query = KeychainSaltItem.keychainQuery(withService: service,
//                                                       account: account,
//                                                       accessGroup: accessGroup)
//            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
//
//            // Throw an error if an unexpected status was returned.
//            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
//        } catch KeychainError.noSalt {
//            /*
//             No password was found in the keychain. Create a dictionary to save
//             as a new keychain item.
//             */
//            var newItem = KeychainSaltItem.keychainQuery(withService: service,
//                                                         account: account,
//                                                         accessGroup: accessGroup)
//            newItem[kSecValueData as String] = salt as AnyObject?
//
//            // Add a the new item to the keychain.
//            let status = SecItemAdd(newItem as CFDictionary, nil)
//
//            // Throw an error if an unexpected status was returned.
//            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
//        }
//    }
//
//    func deleteItem() throws {
//        // Delete the existing item from the keychain.
//        let query = KeychainSaltItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
//        let status = SecItemDelete(query as CFDictionary)
//
//        // Throw an error if an unexpected status was returned.
//        guard status == noErr || status == errSecItemNotFound else {
//            throw KeychainError.unhandledError(status: status) }
//    }
//
//    static func saltItems(forService service: String, accessGroup: String? = nil) throws -> [KeychainSaltItem] {
//        // Build a query for all items that match the service and access group.
//        var query = KeychainSaltItem.keychainQuery(withService: service, accessGroup: accessGroup)
//        query[kSecMatchLimit as String] = kSecMatchLimitAll
//        query[kSecReturnAttributes as String] = kCFBooleanTrue
//        query[kSecReturnData as String] = kCFBooleanFalse
//
//        // Fetch matching items from the keychain.
//        var queryResult: AnyObject?
//        let status = withUnsafeMutablePointer(to: &queryResult) {
//            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
//        }
//
//        // If no items were found, return an empty array.
//        guard status != errSecItemNotFound else { return [] }
//
//        // Throw an error if an unexpected status was returned.
//        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
//
//        // Cast the query result to an array of dictionaries.
//        guard let resultData = queryResult as? [[String: AnyObject]] else { throw KeychainError.unexpectedItemData }
//
//        // Create a `KeychainPasswordItem` for each dictionary in the query result.
//        var saltItems = [KeychainSaltItem]()
//        for result in resultData {
//            guard let account = result[kSecAttrAccount as String] as? String else {
//                throw KeychainError.unexpectedItemData }
//
//            let saltItem = KeychainSaltItem(service: service, account: account, accessGroup: accessGroup)
//            saltItems.append(saltItem)
//        }
//
//        return saltItems
//    }
//
//    // MARK: - Convenience
//
//    private static func keychainQuery(withService service: String,
//                                      account: String? = nil,
//                                      accessGroup: String? = nil) -> [String: AnyObject] {
//        var query = [String: AnyObject]()
//        query[kSecClass as String] = kSecClassGenericPassword
//        query[kSecAttrService as String] = service as AnyObject?
//
//        if let account = account {
//            query[kSecAttrAccount as String] = account as AnyObject?
//        }
//
//        if let accessGroup = accessGroup {
//            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
//        }
//
//        return query
//    }
//}

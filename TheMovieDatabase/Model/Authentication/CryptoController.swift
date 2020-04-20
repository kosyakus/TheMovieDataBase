//
//  CryptoController.swift
//  TheMovieDatabase
//
//  Created by Natali on 19.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import CommonCrypto
import Foundation
import Security

class CryptoController {
    
    ///Generate Salt
    func randomGenerateBytes(count: Int) throws -> Data {
        var bytes = [Int8](repeating: 0, count: count)
        let status = CCRandomGenerateBytes(&bytes, bytes.count)
        try CryptorError.verify(status)
        let data = Data(bytes: bytes, count: bytes.count)
        /// TODO: Сохранить соль в keychain
        //try? ManageKeychain().saveSalt(item: data, user: KeychainUser())
        KeychainSaltItem.save(key: "salt", data: data)
        print("Generated SALT \(data.map { String(format: "%02x", $0) }.joined())")
        return data
    }
    
    /// Derive a key from a text password/passphrase.
    ///
    /// - Parameters:
    ///   - keyCount: The expected length of the derived key in bytes. (для AES256, ключ 256 бит (32 байта))
    ///   - rounds: The rounds parameter is used to make the calculation slow so that an attacker will have to spend substantial time on each attempt. Typical delay values fall in the 100ms to 500ms, shorter values can be used if there is unacceptable performance.
    /// - Returns: Derived key.
    /// - Throws: `CryptorError`.
    /// Немного укоротила функцию, т к все параметры известны кроме пинкода
    /// func pbkdf2SHA512(password: String, salt: Data, keyByteCount: Int, rounds: Int) -> Data?
    func pbkdf2SHA256(password: String, salt: Data) throws -> Data? {
        try pbkdf2(hash: CCPBKDFAlgorithm(kCCPRFHmacAlgSHA256),
                          password: password,
                          salt: salt,
                          rounds: 1000)
    }
    
    func pbkdf2(hash: CCPBKDFAlgorithm,
                password: String,
                salt: Data,
                rounds: UInt32) throws -> Data? {
        
        let length = kCCKeySizeAES256
        var derivedKey = [UInt8](repeating: 0, count: length)
        
        let status = salt.withUnsafeBytes { (saltBuffer: UnsafeRawBufferPointer) -> CCStatus in
            CCKeyDerivationPBKDF(
                CCPBKDFAlgorithm(kCCPBKDF2),
                password, password.utf8.count,
                saltBuffer.bindMemory(to: UInt8.self).baseAddress,
                salt.count,
                hash,
                rounds,
                &derivedKey, derivedKey.count)
        }
        try CryptorError.verify(status)
        print("Generated KEY \(Data(derivedKey).map { String(format: "%02x", $0) }.joined())")
        return Data(derivedKey)
    }
}

public struct CryptorError: Error, RawRepresentable, Hashable {
    public let rawValue: CCStatus
    
    public init(rawValue: CCStatus) {
        self.rawValue = rawValue
    }
    
    static func verify(_ status: CCCryptorStatus) throws {
        if status == kCCSuccess { return }
        throw CryptorError(rawValue: status)
    }
}

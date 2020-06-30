//
//  AESController.swift
//  TheMovieDatabase
//
//  Created by Natali on 19.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import CommonCrypto
import Foundation
import Security

class AESController {
    func crypt(operation: Int,
               options: Int,
               key: Data,
               initializationVector: Data,
               dataIn: Data) -> Data? {
        
        key.withUnsafeBytes { keyUnsafeRawBufferPointer in
            dataIn.withUnsafeBytes { dataInUnsafeRawBufferPointer in
                initializationVector.withUnsafeBytes { ivUnsafeRawBufferPointer in
                    // Give the data out some breathing room for PKCS7's padding.
                    let dataOutSize: Int = dataIn.count + kCCBlockSizeAES128 * 2
                    let dataOut = UnsafeMutableRawPointer.allocate(byteCount: dataOutSize,
                                                                   alignment: 1)
                    defer { dataOut.deallocate() }
                    var dataOutMoved: Int = 0
                    let status = CCCrypt(CCOperation(operation),
                                         CCAlgorithm(kCCAlgorithmAES),
                                         CCOptions(options),
                                         keyUnsafeRawBufferPointer.baseAddress,
                                         key.count,
                                         ivUnsafeRawBufferPointer.baseAddress,
                                         dataInUnsafeRawBufferPointer.baseAddress, dataIn.count,
                                         dataOut, dataOutSize, &dataOutMoved)
                    guard status == kCCSuccess else { return nil }
                    return Data(bytes: dataOut, count: dataOutMoved)
                }
            }
        }
    }
    
    func randomGenerateBytes(count: Int) -> Data? {
        let bytes = UnsafeMutableRawPointer.allocate(byteCount: count, alignment: 1)
        defer { bytes.deallocate() }
        let status = CCRandomGenerateBytes(bytes, count)
        guard status == kCCSuccess else { return nil }
        return Data(bytes: bytes, count: count)
    }
}

extension Data {
    /// Encrypts for you with all the good options turned on: CBC, an IV, PKCS7
    /// padding (so your input data doesn't have to be any particular length).
    /// Key can be 128, 192, or 256 bits.
    /// Generates a fresh IV for you each time, and prefixes it to the returned cryptotext.
    func encryptAES256_CBC_PKCS7_IV(key: Data) -> Data? {
        let aes = AESController()
        guard let iv = aes.randomGenerateBytes(count: kCCBlockSizeAES128) else { return nil }
        // No option is needed for CBC, it is on by default.
        guard let cryptotext = aes.crypt(operation: kCCEncrypt,
                                         options: kCCOptionPKCS7Padding,
                                         key: key,
                                         initializationVector: iv,
                                         dataIn: self) else { return nil }
        return iv + cryptotext
    }
    
    /// Decrypts self, where self is the IV then the ciphertext.
    /// Key can be 128/192/256 bits.
    func decryptAES256_CBC_PKCS7_IV(key: Data) -> Data? {
        guard count > kCCBlockSizeAES128 else { return nil }
        let aes = AESController()
        let iv = prefix(kCCBlockSizeAES128)
        let cryptotext = suffix(from: kCCBlockSizeAES128)
        return aes.crypt(operation: kCCDecrypt,
                         options: kCCOptionPKCS7Padding,
                         key: key,
                         initializationVector: iv,
                         dataIn: cryptotext)
    }
}

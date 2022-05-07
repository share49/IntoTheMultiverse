//
//  CryptoKitHelper.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation
import CryptoKit

struct CryptoKitHelper {
    
    enum CryptoError: Error {
        case invalidString
    }
    
    // MARK: - Internal methods
    
    /// Get MD5 digest of a given string. Throws if string can't be converted to data.
    static func MD5(string: String) throws -> String {
        guard let data = string.data(using: .utf8) else {
            throw CryptoError.invalidString
        }
        
        #warning("MD5 is considered insecure. Replace when API updates.")
        let digest = Insecure.MD5.hash(data: data)
        return digest.map { String(format: k.CryptoKit.MD5StringFormat, $0) }.joined()
    }
}

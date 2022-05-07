//
//  Constants.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

/// Constants
struct k {
    
    // MARK: - Networking constants
    
    /// API constants: API keys
    struct API {
        
        //#error("Set public and private key to test the app. API keys are available for free on https://developer.marvel.com")
        static let publicKey = ""
        static let privateKey = ""
    }
    
    /// CryptoKit constants: String format
    struct CryptoKit {
        
        static let MD5StringFormat = "%02hhx"
    }
}

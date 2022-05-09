//
//  Constants.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import UIKit

/// Global constants used in the app
struct k {
    
    // MARK: - Networking constants
    
    /// API constants: API keys
    struct API {
        
        #error("Set public and private key to test the app. API keys are available for free on https://developer.marvel.com")
        static let publicKey = ""
        static let privateKey = ""
        
        static let scheme = "https"
        static let host = "gateway.marvel.com"
        
        struct Path {
            
            static let characters = "v1/public/characters"
        }
        
        struct QueryItems {
            
            static let timestamp = "ts"
            static let apiKey = "apikey"
            static let hash = "hash"
        }
    }
    
    /// CryptoKit constants: String format
    struct CryptoKit {
        
        static let MD5StringFormat = "%02hhx"
    }
    
    /// UI constants: TableView cells
    struct UI {
        
        struct Cells {
            
            static let characterCell = "characterCell"
        }
        
        static let titleCharactersVC = "Comic characters"
        static let margin: CGFloat = 12
    }
}

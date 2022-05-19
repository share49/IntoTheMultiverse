//
//  Constants.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import UIKit

/// Global constants used in the app
struct Constants {
    
    // MARK: - Networking constants
    
    /// API constants: API keys
    struct API {
        
        #error("Set public and private key to test the app. API keys are available for free on https://developer.marvel.com")
        static let publicKey = ""
        static let privateKey = ""
        
        static let scheme = "https"
        static let host = "gateway.marvel.com"
        
        static let paginationBottomIndex = 5
        
        struct Path {
            
            static let characters = "v1/public/characters"
        }
        
        struct QueryItems {
            
            static let timestamp = "ts"
            static let apiKey = "apikey"
            static let hash = "hash"
            static let offset = "offset"
        }
        
        struct ErrorCodes {
            
            static let noConnection = -1009 // No network connection
        }
    }
    
    // MARK: - CryptoKit constants
    
    /// CryptoKit constants: String format
    struct CryptoKit {
        
        static let MD5StringFormat = "%02hhx"
    }
    
    // MARK: - UI constants
    
    /// UI constants: TableView cells
    struct UI {
        
        struct Cells {
            
            static let characterCell = "characterCell"
            static let comicCell = "comicCell"
        }
        
        static let margin: CGFloat = 12
        static let cellImageHeight: CGFloat = 80
        static let comicsTableViewHeight: CGFloat = 200
    }
    
    // MARK: - ViewsText constants
    
    /// Strings to be localized used in the views. E.g. title of a view controller, error messages..
    struct ViewsText {
        
        static let titleCharactersVC = "Comic characters"
        static let alertTitleError = "Error"
        static let ok = "Ok"
        static let networkErrorMessage = "Network connection error. Please check your connection and retry."
        static let defaultErrorMessage = "Something happened. Please try again."
        static let cantUpdateFavoriteErrorMessage = "Couldn't update favorite. Please try again."
    }
    
    // MARK: - EasterEgg constants
    
    /// EasterEgg constants: Variables to setup the EasterEgg SwiftUI view
    struct EasterEgg {
        
        static let imageUrl = "https://terrigen-cdn-dev.marvel.com/content/prod/1x/doctorstrangeinthemultiverseofmadness_lob_crd_02_3.jpg"
        static let title = "Doctor Strange in the Multiverse of Madness (May 6, 2022)"
        static let rotation: CGFloat = 360
        static let rotationDuration: Double = 1
    }
}

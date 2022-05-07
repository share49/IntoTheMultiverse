//
//  ResponseData.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

struct ResponseData: Decodable {
    
    // MARK: - Properties
    
    let comicCharacters: [ComicCharacter]
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case comicCharacters = "results"
    }
}

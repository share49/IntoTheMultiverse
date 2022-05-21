//
//  CharactersData.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

struct CharactersData: Decodable {
    
    // MARK: - Properties
    
    let comicCharacters: [ComicCharacter]
    let total: Int
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case comicCharacters = "results"
        case total
    }
}

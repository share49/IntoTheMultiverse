//
//  ComicCharacter.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

struct ComicCharacter: Decodable {
    
    // MARK: - Properties
    
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, thumbnail
    }
}

//
//  CharacterResponse.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

struct CharacterResponse: Decodable {
    
    // MARK: - Properties
    
    let data: ResponseData
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}

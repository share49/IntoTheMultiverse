//
//  Item.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/18/22.
//

import Foundation

struct Item: Decodable {
    
    // MARK: - Properties
    
    let name: String
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
}

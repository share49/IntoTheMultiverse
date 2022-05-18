//
//  Comics.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/18/22.
//

import Foundation

struct Comics: Decodable {
    
    // MARK: - Properties
    
    let available: Int
    let returned: Int
    let items: [Item]
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case available, returned, items
    }
}

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

#if DEBUG
extension Comics {
    
    static let previewData = Comics(available: 2, returned: 2, items: [Item(name: "Volume 1"), Item(name: "Volume 2")])
}
#endif

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
    let comics: Comics
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, thumbnail, comics
    }
}

// MARK: - PreviewData

#if DEBUG
extension ComicCharacter {
    
    static let previewData = ComicCharacter(
        id: 4,
        name: "Star-Lord",
        description: "Peter Jason Quill is a Celestial-Human hybrid who was abducted from Earth in 1988",
        thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", fileExtension: "jpg"),
        comics: Comics.previewData
    )
}
#endif

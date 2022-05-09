//
//  Thumbnail.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/9/22.
//

import Foundation

struct Thumbnail: Decodable {
    
    // MARK: - Properties
    
    let path: String
    let fileExtension: String
    var url: URL? {
        var urlComponents = URLComponents(string: "\(path).\(fileExtension)")
        urlComponents?.scheme = k.API.scheme
        return urlComponents?.url
    }
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}

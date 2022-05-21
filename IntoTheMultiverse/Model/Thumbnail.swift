//
//  Thumbnail.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/9/22.
//

import Foundation

struct Thumbnail: Decodable {
    
    // MARK: - Enum
    
    /// Thumbnail sizes. Check https://developer.marvel.com/documentation/images to see all the available ones.
    enum ThumbnailSize: String {
        case original
        case squareSmall = "standard_small"
        case squareMedium = "standard_medium"
    }
    
    // MARK: - Properties
    
    let path: String
    let fileExtension: String
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
    
    // MARK: - Methods
    
    /// Thumbnail URL for the specific size.
    func url(for thumbnailSize: ThumbnailSize) -> URL? {
        let urlString: String
        
        switch thumbnailSize {
        case .original:
            urlString = "\(path).\(fileExtension)"
        case .squareSmall, .squareMedium:
            urlString = "\(path)/\(thumbnailSize.rawValue).\(fileExtension)"
        }
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.scheme = Constants.API.scheme
        return urlComponents?.url
    }
}

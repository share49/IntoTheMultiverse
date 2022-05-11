//
//  Endpoint.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

struct Endpoint {
    
    // MARK: - Properties
    
    var path: String
    var queryItems = [URLQueryItem]()
    var url: URL {
        var components = URLComponents()
        components.scheme = Constants.API.scheme
        components.host = Constants.API.host
        components.path = "/" + path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }

        return url
    }
    
    // MARK: - Endpoints

    static func comicCharacters(with queryItems: [URLQueryItem]) -> Self {
        Endpoint(path: Constants.API.Path.characters, queryItems: queryItems)
    }
    
    static func comicCharacter(for id: Int, with queryItems: [URLQueryItem]) -> Self {
        Endpoint(path: "\(Constants.API.Path.characters)/\(id)", queryItems: queryItems)
    }
    
    // MARK: - Support methods
    
    static func buildRequiredQueryItems(for date: Date = Date(),
                                        privateKey: String = Constants.API.privateKey,
                                        publicKey: String = Constants.API.publicKey) throws -> [URLQueryItem] {
        let timestamp = "\(date.timeIntervalSince1970)"
        let stringToHash = "\(timestamp)\(privateKey)\(publicKey)"
        let hash = try CryptoKitHelper.MD5(string: stringToHash)
        
        let queryItems = [
            URLQueryItem(name: Constants.API.QueryItems.timestamp, value: timestamp),
            URLQueryItem(name: Constants.API.QueryItems.apiKey, value: publicKey),
            URLQueryItem(name: Constants.API.QueryItems.hash, value: hash)
        ]
        
        return queryItems
    }
}

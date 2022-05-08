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
        components.scheme = k.API.scheme
        components.host = k.API.host
        components.path = "/" + path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }

        return url
    }
    
    // MARK: - Endpoints

    static func comicCharacters(with queryItems: [URLQueryItem]) -> Self {
        Endpoint(path: k.API.Path.characters, queryItems: queryItems)
    }
    
    // MARK: - Support methods
    
    static func buildRequiredQueryItems(for date: Date = Date(),
                                        privateKey: String = k.API.privateKey,
                                        publicKey: String = k.API.publicKey) throws -> [URLQueryItem] {
        let timestamp = "\(date.timeIntervalSince1970)"
        let stringToHash = "\(timestamp)\(privateKey)\(publicKey)"
        let hash = try CryptoKitHelper.MD5(string: stringToHash)
        
        let queryItems = [
            URLQueryItem(name: k.API.QueryItems.timestamp, value: timestamp),
            URLQueryItem(name: k.API.QueryItems.apiKey, value: publicKey),
            URLQueryItem(name: k.API.QueryItems.hash, value: hash)
        ]
        
        return queryItems
    }
}

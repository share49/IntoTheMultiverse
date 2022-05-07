//
//  NetworkProvider.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

protocol NetworkProvider {
    
    func getCharacters(using session: URLSession) async throws -> [ComicCharacter]
}

extension NetworkProvider {
    
    func decode<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}

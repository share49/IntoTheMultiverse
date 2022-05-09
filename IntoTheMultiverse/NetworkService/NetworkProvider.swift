//
//  NetworkProvider.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

enum NetworkProviderError: Error {
    case emptyCharactersArray
    
    // MockNetworkService errors
    case invalidFilePath
}

protocol NetworkProvider {
    
    func getCharacters() async throws -> [ComicCharacter]
    func getCharacter(for id: Int) async throws -> ComicCharacter
}

extension NetworkProvider {
    
    func decode<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}

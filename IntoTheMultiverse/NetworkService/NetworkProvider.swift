//
//  NetworkProvider.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

enum NetworkProviderError: Error {
    case emptyCharactersArray
    case noConnection
    
    // MockNetworkService errors
    case invalidFilePath
}

protocol NetworkProvider {
    
    func getCharacters(offsetBy offset: Int) async throws -> [ComicCharacter]
    func getCharacter(for id: Int) async throws -> ComicCharacter
}

extension NetworkProvider {
    
    func decode<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
    
    /// Returns the first comic character from a CharacterResponse that has the desired comic character id. Throws if it's unable to find it.
    func parseCharacter(from response: CharacterResponse, forId id: Int) throws -> ComicCharacter {
        guard let comicCharacter = response.data.comicCharacters.first(where: { $0.id == id }) else {
            throw NetworkProviderError.emptyCharactersArray
        }
        
        return comicCharacter
    }
}

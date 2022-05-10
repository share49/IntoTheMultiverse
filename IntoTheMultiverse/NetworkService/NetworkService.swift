//
//  NetworkService.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

struct NetworkService: NetworkProvider {
    
    // MARK: - NetworkProvider
    
    func getCharacters() async throws -> [ComicCharacter] {
        do {
            let requiredQueryItems = try Endpoint.buildRequiredQueryItems()
            let url = Endpoint.comicCharacters(with: requiredQueryItems).url
            let characterResponse: CharacterResponse = try await getAndDecode(url: url)
            return characterResponse.data.comicCharacters
        } catch {
            throw error
        }
    }
    
    func getCharacter(for id: Int) async throws -> ComicCharacter {
        do {
            let requiredQueryItems = try Endpoint.buildRequiredQueryItems()
            let url = Endpoint.comicCharacter(for: id, with: requiredQueryItems).url
            let characterResponse: CharacterResponse = try await getAndDecode(url: url)
            
            guard let comicCharacter = characterResponse.data.comicCharacters.first else {
                throw NetworkProviderError.emptyCharactersArray
            }
            
            return comicCharacter
        } catch {
            throw error
        }
    }
    
    // MARK: - Support methods
    
    private func getAndDecode<T: Decodable>(url: URL) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try decode(data: data)
        } catch {
            if (error as NSError).code == k.API.ErrorCodes.noConnection {
                throw NetworkProviderError.noConnection
            } else {
                throw error
            }
        }
    }
}

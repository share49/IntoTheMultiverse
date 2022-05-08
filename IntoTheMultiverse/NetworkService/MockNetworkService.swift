//
//  MockNetworkService.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

struct MockNetworkService: NetworkProvider {
    
    enum NetworkProviderError: Error {
        case invalidFilePath
    }
    
    // MARK: - NetworkProvider
    
    func getCharacters() async throws -> [ComicCharacter] {
        let characterResponse: CharacterResponse = try await loadMockData(for: "characters", ofType: "json")
        return characterResponse.data.comicCharacters
    }
    
    // MARK: - Support methods
    
    private func loadMockData<T: Decodable>(for resource: String, ofType type: String) async throws -> T {
        guard let filepath = Bundle.main.path(forResource: resource, ofType: type) else {
            throw NetworkProviderError.invalidFilePath
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filepath))
            return try decode(data: data)
        } catch {
            throw error
        }
    }
}

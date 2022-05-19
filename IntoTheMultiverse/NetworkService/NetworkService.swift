//
//  NetworkService.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

struct NetworkService: NetworkProvider {
    
    // MARK: - Properties
    
    private let urlSession: URLSession
    
    // MARK: - Initializer
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - NetworkProvider
    
    func getCharacters() async throws -> [ComicCharacter] {
        let requiredQueryItems = try Endpoint.buildRequiredQueryItems()
        let url = Endpoint.comicCharacters(with: requiredQueryItems).url
        let characterResponse: CharacterResponse = try await getAndDecode(url: url)
        return characterResponse.data.comicCharacters
    }
    
    func getCharacter(for id: Int) async throws -> ComicCharacter {
        let requiredQueryItems = try Endpoint.buildRequiredQueryItems()
        let url = Endpoint.comicCharacter(for: id, with: requiredQueryItems).url
        let characterResponse: CharacterResponse = try await getAndDecode(url: url)
        return try parseCharacter(from: characterResponse, forId: id)
    }
    
    // MARK: - Support methods
    
    private func getAndDecode<T: Decodable>(url: URL) async throws -> T {
        do {
            let (data, _) = try await urlSession.data(from: url)
            return try decode(data: data)
        } catch {
            if (error as NSError).code == Constants.API.ErrorCodes.noConnection {
                throw NetworkProviderError.noConnection
            } else {
                throw error
            }
        }
    }
}

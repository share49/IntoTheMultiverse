//
//  NetworkService.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

struct NetworkService: NetworkProvider {
    
    // MARK: - NetworkProvider
    
    func getCharacters(using session: URLSession) async throws -> [ComicCharacter] {
        []
    }
}

//
//  CharactersViewModel.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

@MainActor class CharactersViewModel {
    
    // MARK: - Properties
    
    private let networkService: NetworkProvider
    @Published private(set) var comicCharacters = [ComicCharacter]()
    
    // MARK: - Initializer
    
    init(with networkService: NetworkProvider = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Load comic characters
    
    func loadComicCharacters() async {
        guard comicCharacters.isEmpty else {
            return
        }
        
        do {
            comicCharacters = try await networkService.getCharacters()
        } catch {
            NSLog("CharactersViewModel: Error loading comic characters. \(error)")
        }
    }
}

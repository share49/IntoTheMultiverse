//
//  CharacterDetailViewModel.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import Foundation

final class CharacterDetailViewModel: ObservableObject {

    // MARK: - Properties
    
    private let networkService: NetworkProvider
    private let characterId: Int
    @Published private(set) var comicCharacter: ComicCharacter?
    
    // MARK: - Initializer
    
    init(with networkService: NetworkProvider = NetworkService(), characterId: Int) {
        self.networkService = networkService
        self.characterId = characterId
    }
    
    // MARK: - Load comic characters
    
    func loadComicCharacter() async {
        do {
            comicCharacter = try await networkService.getCharacter(for: characterId)
        } catch {
            NSLog("CharacterDetailViewModel: Error loading comic character. \(error)")
        }
    }
}

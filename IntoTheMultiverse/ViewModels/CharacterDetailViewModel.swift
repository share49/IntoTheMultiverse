//
//  CharacterDetailViewModel.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import Foundation

@MainActor class CharacterDetailViewModel {
    
    // MARK: - Properties
    
    private let networkService: NetworkProvider
    private let characterId: Int
    private let persistenceManager: PersistenceHandler
    @Published private(set) var comicCharacter: ComicCharacter?
    @Published private(set) var isLoading = false
    @Published private(set) var alertMessage: String?
    @Published private(set) var isFavorite = false
    
    // MARK: - Initializer
    
    init(with networkService: NetworkProvider = NetworkService(), characterId: Int, persistenceManager: PersistenceHandler) {
        self.networkService = networkService
        self.characterId = characterId
        self.persistenceManager = persistenceManager
        
        updateIsFavoriteState()
    }
    
    // MARK: - Load comic characters
    
    func loadComicCharacter() async {
        defer { isLoading = false }
        
        do {
            isLoading = true
            comicCharacter = try await networkService.getCharacter(for: characterId)
        } catch NetworkProviderError.noConnection {
            alertMessage = Constants.ViewsText.networkErrorMessage
            NSLog("CharacterDetailViewModel: NetworkProviderError.noConnection")
        } catch {
            alertMessage = Constants.ViewsText.defaultErrorMessage
            NSLog("CharacterDetailViewModel: Error loading comic character. \(error)")
        }
    }
    
    // MARK: - Favorite methods

    func handleFavoritesTap() {
        updateFavorite(!persistenceManager.isFavorite(characterId))
    }
    
    private func updateIsFavoriteState() {
        isFavorite = persistenceManager.isFavorite(characterId)
    }
    
    private func updateFavorite(_ isFavorite: Bool) {
        do {
            try persistenceManager.saveFavoriteState(for: characterId, isFavorite: isFavorite)
            self.isFavorite = isFavorite
        } catch {
            alertMessage = Constants.ViewsText.cantUpdateFavoriteErrorMessage
            NSLog("CharacterDetailViewModel: Couldn't remove favorite.")
        }
    }
}

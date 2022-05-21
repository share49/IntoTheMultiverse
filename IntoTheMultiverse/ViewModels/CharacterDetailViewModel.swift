//
//  CharacterDetailViewModel.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import Foundation

final class CharacterDetailViewModel {
    
    // MARK: - Properties
    
    private let networkService: NetworkProvider
    private let characterId: Int
    private let persistenceManager: PersistenceHandler
    private let logger: LogHandler
    @Published private(set) var comicCharacter: ComicCharacter?
    @Published private(set) var isLoading = false
    @Published private(set) var alertMessage: String?
    @Published private(set) var isFavorite = false
    var comicsCount: Int {
        comicCharacter?.comics.items.count ?? 0
    }
    
    // MARK: - Initializer
    
    init(with networkService: NetworkProvider = NetworkService(), characterId: Int, persistenceManager: PersistenceHandler, logger: LogHandler) {
        self.networkService = networkService
        self.characterId = characterId
        self.persistenceManager = persistenceManager
        self.logger = logger
        
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
            logger.error("CharacterDetailViewModel: NetworkProviderError.noConnection")
        } catch {
            alertMessage = Constants.ViewsText.defaultErrorMessage
            logger.error("CharacterDetailViewModel: Error loading comic character. \(error)")
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
            try persistenceManager.saveFavoriteState(isFavorite, for: characterId)
            self.isFavorite = isFavorite
        } catch {
            alertMessage = Constants.ViewsText.cantUpdateFavoriteErrorMessage
            logger.error("CharacterDetailViewModel: Couldn't remove favorite.")
        }
    }
    
    // MARK: - Properties
    
    func comicName(for indexPath: IndexPath) -> String? {
        comicCharacter?.comics.items[indexPath.row].name
    }
}

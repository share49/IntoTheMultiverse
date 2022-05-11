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
    @Published private(set) var isLoading = false
    @Published private(set) var comicCharacters = [ComicCharacter]()
    @Published private(set) var alertMessage: String?
    
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
            isLoading = true
            comicCharacters = try await networkService.getCharacters()
        } catch NetworkProviderError.noConnection {
            alertMessage = Constants.ViewsText.networkErrorMessage
            NSLog("CharactersViewModel: NetworkProviderError.noConnection")
        } catch {
            alertMessage = Constants.ViewsText.defaultErrorMessage
            NSLog("CharactersViewModel: Error loading comic characters. \(error)")
        }
        
        isLoading = false
    }
    
    // MARK: - Methods
    
    func getCharacterName(for indexPath: IndexPath) -> String {
        comicCharacters[indexPath.row].name
    }
    
    func getCharacterId(for indexPath: IndexPath) -> Int {
        comicCharacters[indexPath.row].id
    }
}

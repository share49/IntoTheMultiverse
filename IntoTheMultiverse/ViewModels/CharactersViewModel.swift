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
            comicCharacters = try await networkService.getCharacters()
        } catch NetworkProviderError.noConnection {
            alertMessage = k.ViewsText.networkErrorMessage
            NSLog("CharactersViewModel: NetworkProviderError.noConnection")
        } catch {
            alertMessage = k.ViewsText.defaultErrorMessage
            NSLog("CharactersViewModel: Error loading comic characters. \(error)")
        }
    }
}

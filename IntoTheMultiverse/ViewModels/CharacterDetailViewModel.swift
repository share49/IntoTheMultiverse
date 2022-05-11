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
    @Published private(set) var comicCharacter: ComicCharacter?
    @Published private(set) var isLoading = false
    @Published private(set) var alertMessage: String?
    
    // MARK: - Initializer
    
    init(with networkService: NetworkProvider = NetworkService(), characterId: Int) {
        self.networkService = networkService
        self.characterId = characterId
    }
    
    // MARK: - Load comic characters
    
    func loadComicCharacter() async {
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
        
        isLoading = false
    }
}

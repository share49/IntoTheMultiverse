//
//  CharactersViewModel.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/7/22.
//

import Foundation

final class CharactersViewModel {
    
    // MARK: - Properties
    
    private let networkService: NetworkProvider
    @Published private(set) var isLoading = false
    @Published private(set) var comicCharacters = [ComicCharacter]()
    @Published private(set) var alertMessage: String?
    private var isFirstLoad: Bool {
        comicCharacters.isEmpty
    }
    
    // MARK: - Initializer
    
    init(with networkService: NetworkProvider = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Load comic characters
    
    func loadFirstComicCharacters() async {
        guard isFirstLoad else {
            return
        }
        
        await loadComicCharacters()
    }
    
    func loadMoreComicCharactersIfNeeded(for indexPath: IndexPath) async {
        let startPaginationIndex = comicCharacters.count - Constants.API.paginationBottomIndex
        if startPaginationIndex <= indexPath.row {
            await loadComicCharacters()
        }
    }
    
    private func loadComicCharacters() async {
        guard !isLoading else {
            return
        }
        
        defer { isLoading = false }
        
        do {
            isLoading = true
            let newComicCharacters = try await networkService.getCharacters(offsetBy: comicCharacters.count)
            comicCharacters.append(contentsOf: newComicCharacters)
        } catch NetworkProviderError.noConnection {
            alertMessage = Constants.ViewsText.networkErrorMessage
            NSLog("CharactersViewModel: NetworkProviderError.noConnection")
        } catch {
            alertMessage = Constants.ViewsText.defaultErrorMessage
            NSLog("CharactersViewModel: Error loading comic characters. \(error)")
        }
    }
    
    // MARK: - Methods
    
    func getCharacter(for indexPath: IndexPath) -> ComicCharacter {
        comicCharacters[indexPath.row]
    }
    
    func getCharacterId(for indexPath: IndexPath) -> Int {
        comicCharacters[indexPath.row].id
    }
}

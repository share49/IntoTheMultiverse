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
    private let logger: LogHandler
    @Published private(set) var isLoading = false
    @Published private(set) var comicCharacters = [ComicCharacter]()
    @Published private(set) var alertMessage: String?
    private var totalCharacters = 1
    private var isFirstLoad: Bool {
        comicCharacters.isEmpty
    }
    
    // MARK: - Initializer
    
    init(with networkService: NetworkProvider = NetworkService(), logger: LogHandler) {
        self.networkService = networkService
        self.logger = logger
    }
    
    // MARK: - Load comic characters
    
    func loadFirstComicCharacters() async {
        guard isFirstLoad else {
            return
        }
        
        await loadComicCharacters()
    }
    
    func loadMoreComicCharactersIfNeeded(for indexPaths: [IndexPath]) async {
        guard let indexPath = indexPaths.last else {
            return
        }
        
        let startPaginationIndex = comicCharacters.count - Constants.API.paginationBottomIndex
        if startPaginationIndex <= indexPath.row {
            await loadComicCharacters()
        }
    }
    
    private func loadComicCharacters() async {
        guard !isLoading else {
            return
        }
        
        let offsetBy = comicCharacters.count
        
        guard offsetBy < totalCharacters else {
            return
        }
        
        defer { isLoading = false }
        
        do {
            isLoading = true
            let responseData = try await networkService.getCharacters(offsetBy: offsetBy)
            totalCharacters = responseData.total
            comicCharacters.append(contentsOf: responseData.comicCharacters)
        } catch NetworkProviderError.noConnection {
            alertMessage = Constants.ViewsText.networkErrorMessage
            logger.error("CharactersViewModel: NetworkProviderError.noConnection")
        } catch {
            alertMessage = Constants.ViewsText.defaultErrorMessage
            logger.error("CharactersViewModel: Error loading comic characters. \(error)")
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

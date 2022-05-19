//
//  CharacterDetailViewModelTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/9/22.
//

import XCTest

@MainActor class CharacterDetailViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    private let mockNetworkService = MockNetworkService()
    private let persistenceManager = PersistenceManager()
    
    // MARK: - Tests
    
    func testLoadComicCharacter() async {
        // Arrange
        let characterId = 1011334
        let viewModel = CharacterDetailViewModel(with: mockNetworkService, characterId: characterId, persistenceManager: persistenceManager)
        
        // Act
        await viewModel.loadComicCharacter()
        
        // Assert
        XCTAssertEqual(viewModel.comicCharacter?.id, characterId)
        XCTAssertEqual(viewModel.comicCharacter?.name, "3-D Man")
    }
    
    func testLoadComicCharacterFailure() async {
        // Arrange
        let characterId = 0
        let viewModel = CharacterDetailViewModel(with: mockNetworkService, characterId: characterId, persistenceManager: persistenceManager)
        
        // Act
        await viewModel.loadComicCharacter()
        
        // Assert
        XCTAssertEqual(viewModel.alertMessage, Constants.ViewsText.defaultErrorMessage)
    }
}

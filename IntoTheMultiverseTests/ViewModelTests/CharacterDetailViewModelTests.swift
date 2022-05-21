//
//  CharacterDetailViewModelTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/9/22.
//

import XCTest
@testable import IntoTheMultiverse

final class CharacterDetailViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    private let mockNetworkService = MockNetworkService()
    private let persistenceManager = MockPersistenceManager(mockIsFavorite: false)
    private let logger = MLogger()
    private let validCharacterId = 1011334
    private let invalidCharacterId = 0
    
    // MARK: - Tests
    
    func testLoadComicCharacter() async {
        // Arrange
        let viewModel = CharacterDetailViewModel(with: mockNetworkService, characterId: validCharacterId, persistenceManager: persistenceManager, logger: logger)
        
        // Act
        await viewModel.loadComicCharacter()
        
        // Assert
        XCTAssertEqual(viewModel.comicCharacter?.id, validCharacterId)
        XCTAssertEqual(viewModel.comicCharacter?.name, "3-D Man")
    }
    
    func testLoadComicCharacterFailure() async {
        // Arrange
        let viewModel = CharacterDetailViewModel(with: mockNetworkService, characterId: invalidCharacterId, persistenceManager: persistenceManager, logger: logger)
        
        // Act
        await viewModel.loadComicCharacter()
        
        // Assert
        XCTAssertEqual(viewModel.alertMessage, Constants.ViewsText.defaultErrorMessage)
    }
    
    func testComicsCount() async {
        // Arrange
        let viewModel = CharacterDetailViewModel(with: mockNetworkService, characterId: validCharacterId, persistenceManager: persistenceManager, logger: logger)
        
        // Act
        await viewModel.loadComicCharacter()
        let comicsCount = viewModel.comicsCount
        
        // Assert
        XCTAssertEqual(comicsCount, 12)
    }
    
    func testComicName() async {
        // Arrange
        let indexPath = IndexPath(row: 0, section: 0)
        let viewModel = CharacterDetailViewModel(with: mockNetworkService, characterId: validCharacterId, persistenceManager: persistenceManager, logger: logger)
        
        // Act
        await viewModel.loadComicCharacter()
        let name = viewModel.comicName(for: indexPath)!
        
        // Assert
        XCTAssertEqual(name, "Avengers: The Initiative (2007) #14")
    }
    
    func testHandleFavoritesTap() async {
        // Arrange
        let expectedIsFavorite = false
        let mockPersistenceManager = MockPersistenceManager(mockIsFavorite: expectedIsFavorite)
        let viewModel = CharacterDetailViewModel(with: mockNetworkService, characterId: validCharacterId, persistenceManager: mockPersistenceManager, logger: logger)
        
        // Act
        await viewModel.loadComicCharacter()
        viewModel.handleFavoritesTap()
        let isFavorite = viewModel.isFavorite
        
        // Assert
        XCTAssertEqual(isFavorite, !expectedIsFavorite)
    }
}

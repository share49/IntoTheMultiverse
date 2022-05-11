//
//  CharactersViewModelTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import XCTest
@testable import IntoTheMultiverse

@MainActor class CharactersViewModelTests: XCTestCase {
    
    // MARK: - Tests

    func testLoadComicCharacters() async throws {
        // Arrange
        let viewModel = CharactersViewModel(with: MockNetworkService())
        
        // Act
        await viewModel.loadComicCharacters()
        
        // Assert
        XCTAssertEqual(viewModel.comicCharacters.count, 20)
    }
    
    func testGetCharacterName() async throws {
        // Arrange
        let viewModel = CharactersViewModel(with: MockNetworkService())
        
        // Act
        await viewModel.loadComicCharacters()
        let characterName = viewModel.getCharacterName(for: IndexPath(row: 0, section: 0))
        
        // Assert
        XCTAssertEqual(characterName, "3-D Man")
    }
    
    func testGetCharacterId() async throws {
        // Arrange
        let viewModel = CharactersViewModel(with: MockNetworkService())
        
        // Act
        await viewModel.loadComicCharacters()
        let characterId = viewModel.getCharacterId(for: IndexPath(row: 0, section: 0))
        
        // Assert
        XCTAssertEqual(characterId, 1011334)
    }
}

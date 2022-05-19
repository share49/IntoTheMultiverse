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
    
    func testLoadComicCharacters() async {
        // Arrange
        let viewModel = CharactersViewModel(with: MockNetworkService())
        
        // Act
        await viewModel.loadComicCharacters()
        
        // Assert
        XCTAssertEqual(viewModel.comicCharacters.count, 20)
    }
    
    func testGetCharacter() async {
        // Arrange
        let viewModel = CharactersViewModel(with: MockNetworkService())
        let indexPath = IndexPath(row: 0, section: 0)
        
        // Act
        await viewModel.loadComicCharacters()
        let character = viewModel.getCharacter(for: indexPath)
        
        // Assert
//        XCTAssertEqual(character, "3-D Man")
        //FixMe
    }
    
    func testGetCharacterId() async {
        // Arrange
        let viewModel = CharactersViewModel(with: MockNetworkService())
        let indexPath = IndexPath(row: 0, section: 0)
        
        // Act
        await viewModel.loadComicCharacters()
        let characterId = viewModel.getCharacterId(for: indexPath)
        
        // Assert
        XCTAssertEqual(characterId, 1011334)
    }
}

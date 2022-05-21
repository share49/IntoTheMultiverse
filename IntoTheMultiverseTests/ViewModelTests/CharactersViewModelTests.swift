//
//  CharactersViewModelTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import XCTest
@testable import IntoTheMultiverse

final class CharactersViewModelTests: XCTestCase {
    
    // MARK: - Tests
    
    func testLoadComicCharacters() async {
        // Arrange
        let viewModel = CharactersViewModel(with: MockNetworkService(), logger: MLogger())
        
        // Act
        await viewModel.loadFirstComicCharacters()
        
        // Assert
        XCTAssertEqual(viewModel.comicCharacters.count, 20)
    }
    
    func testGetCharacter() async {
        // Arrange
        let viewModel = CharactersViewModel(with: MockNetworkService(), logger: MLogger())
        let indexPath = IndexPath(row: 0, section: 0)
        
        // Act
        await viewModel.loadFirstComicCharacters()
        let character = viewModel.getCharacter(for: indexPath)
        
        // Assert
//        XCTAssertEqual(character, "3-D Man")
        //FixMe
    }
    
    func testGetCharacterId() async {
        // Arrange
        let viewModel = CharactersViewModel(with: MockNetworkService(), logger: MLogger())
        let indexPath = IndexPath(row: 0, section: 0)
        
        // Act
        await viewModel.loadFirstComicCharacters()
        let characterId = viewModel.getCharacterId(for: indexPath)
        
        // Assert
        XCTAssertEqual(characterId, 1011334)
    }
}

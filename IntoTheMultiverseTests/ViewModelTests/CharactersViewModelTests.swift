//
//  CharactersViewModelTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import XCTest
@testable import IntoTheMultiverse

final class CharactersViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    private let numberOfItemsFetchedPerBatch = 20
    
    // MARK: - Tests
    
    func testLoadComicCharacters() async {
        // Arrange
        let viewModel = CharactersViewModel(with: MockNetworkService(), logger: MLogger())
        
        // Act
        await viewModel.loadFirstComicCharacters()
        
        // Assert
        XCTAssertEqual(viewModel.comicCharacters.count, numberOfItemsFetchedPerBatch)
    }
    
    func testGetCharacter() async {
        // Arrange
        let viewModel = CharactersViewModel(with: MockNetworkService(), logger: MLogger())
        let indexPath = IndexPath(row: 4, section: 0)
        
        // Act
        await viewModel.loadFirstComicCharacters()
        let character = viewModel.getCharacter(for: indexPath)
        
        // Assert
        XCTAssertEqual(character.name, "Abomination (Emil Blonsky)")
        XCTAssertEqual(character.id, 1009146)
        XCTAssertEqual(character.comics.items.count, 20)
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
    
    func testLoadMoreComicCharactersIfNeededWhenThereAreNot() async {
        // Arrange
        let indexPaths = [IndexPath(row: 10, section: 0)]
        let viewModel = CharactersViewModel(with: MockNetworkService(), logger: MLogger())
        
        // Act
        await viewModel.loadFirstComicCharacters()
        await viewModel.loadMoreComicCharactersIfNeeded(for: indexPaths)
        let charactersNumber = viewModel.comicCharacters.count
        
        // Assert
        XCTAssertEqual(charactersNumber, numberOfItemsFetchedPerBatch)
    }
    
    func testLoadMoreComicCharactersIfNeeded() async {
        // Arrange
        let expectedNumberOfCharacters = numberOfItemsFetchedPerBatch * 2
        let expectedRefreshIndex = numberOfItemsFetchedPerBatch - Constants.API.paginationBottomIndex
        let indexPaths = [IndexPath(row: expectedRefreshIndex, section: 0)]
        let viewModel = CharactersViewModel(with: MockNetworkService(), logger: MLogger())
        
        // Act
        await viewModel.loadFirstComicCharacters()
        await viewModel.loadMoreComicCharactersIfNeeded(for: indexPaths)
        let charactersNumber = viewModel.comicCharacters.count
        
        // Assert
        XCTAssertEqual(charactersNumber, expectedNumberOfCharacters)
    }
}

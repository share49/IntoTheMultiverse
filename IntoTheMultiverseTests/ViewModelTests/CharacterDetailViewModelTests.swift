//
//  CharacterDetailViewModelTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/9/22.
//

import XCTest

final class CharacterDetailViewModelTests: XCTestCase {
    
    // MARK: - Tests
    
    func testLoadComicCharacter() async throws {
        // Arange
        let characterId = 1011334
        let viewModel = CharacterDetailViewModel(with: MockNetworkService(), characterId: characterId)
        
        // Act
        await viewModel.loadComicCharacter()
        
        // Assert
        XCTAssertEqual(viewModel.comicCharacter?.id, characterId)
        XCTAssertEqual(viewModel.comicCharacter?.name, "3-D Man")
    }
    
    func testLoadComicCharacterFailure() async throws {
        // Arange
        let characterId = 0
        let viewModel = CharacterDetailViewModel(with: MockNetworkService(), characterId: characterId)
        
        // Act
        await viewModel.loadComicCharacter()
        
        // Assert
        XCTAssertEqual(viewModel.alertMessage, k.ViewsText.defaultErrorMessage)
    }
}

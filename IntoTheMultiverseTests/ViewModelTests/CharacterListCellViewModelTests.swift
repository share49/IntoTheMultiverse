//
//  CharacterListCellViewModelTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/18/22.
//

import XCTest
@testable import IntoTheMultiverse

@MainActor class CharacterListCellViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    let comicCharacter = ComicCharacter.previewData
    lazy var viewModel = CharacterListCellViewModel(with: comicCharacter)
    
    // MARK: - Tests
    
    func testTitle() {
        // Arrange
        let expectedTitle = comicCharacter.name
        
        // Act
        let title = viewModel.title
        
        // Assert
        XCTAssertEqual(title, expectedTitle)
    }
    
    func testThumbnailUrl() {
        // Arrange
        let expectedThumbnailUrl = comicCharacter.thumbnail.url(for: .squareMedium)
        
        // Act
        let thumbnailUrl = viewModel.thumbnailURL
        
        // Assert
        XCTAssertEqual(thumbnailUrl, expectedThumbnailUrl)
    }
}

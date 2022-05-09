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
        let characterId = 1011334
        let viewModel = CharacterDetailViewModel(with: MockNetworkService(), characterId: characterId)
        await viewModel.loadComicCharacter()
        XCTAssertEqual(viewModel.comicCharacter?.id, characterId)
        XCTAssertEqual(viewModel.comicCharacter?.name, "3-D Man")
    }
}

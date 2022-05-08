//
//  CharactersViewModelTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import XCTest
@testable import IntoTheMultiverse

@MainActor class CharactersViewModelTests: XCTestCase {

    func testLoadComicCharacters() async throws {
        let viewModel = CharactersViewModel(with: MockNetworkService())
        await viewModel.loadComicCharacters()
        XCTAssertEqual(viewModel.comicCharacters.count, 20)
    }
}

//
//  NetworkProviderTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/5/22.
//

import XCTest
@testable import IntoTheMultiverse

class NetworkProviderTests: XCTestCase {
    
    // MARK: - Properties

    private let mockNetworkService = MockNetworkService()
    
    // MARK: - Tests

    func testGetCharacters() async throws {
        do {
            let characters = try await mockNetworkService.getCharacters(using: .shared)
            XCTAssertEqual(characters.count, 20)
            
            guard let firstCharacter = characters.first, let lastCharacter = characters.last else {
                XCTFail("Can't get first and last characters")
                return
            }
            
            XCTAssertEqual(firstCharacter.id, 1011334)
            XCTAssertEqual(firstCharacter.name, "3-D Man")
            XCTAssertEqual(lastCharacter.id, 1011136)
            XCTAssertEqual(lastCharacter.name, "Air-Walker (Gabriel Lan)")
        } catch {
            XCTFail()
        }
    }
}

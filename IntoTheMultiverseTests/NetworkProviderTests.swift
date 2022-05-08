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
            let characters = try await mockNetworkService.getCharacters()
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
    
    // MARK: - Endpoints
    
    func testComicCharactersEndpoint() {
        do {
            let date = Date(timeIntervalSince1970: 10)
            let mockApiPrivateKey = "1234"
            let mockApiPublicKey = "5678"
            let queryItems = try Endpoint.buildRequiredQueryItems(for: date, privateKey: mockApiPrivateKey, publicKey: mockApiPublicKey)
            let endpoint = Endpoint.comicCharacters(with: queryItems)

            let timestamp = date.timeIntervalSince1970
            let stringUrl = "https://gateway.marvel.com/v1/public/characters?ts=\(timestamp)&apikey=\(mockApiPublicKey)&hash=cbb69d600ef72467747f0842290684ad"
            let expectedUrl = URL(string: stringUrl)
            XCTAssertEqual(endpoint.url, expectedUrl)
        } catch {
            XCTFail("Unable to build endpoint")
        }
    }
}

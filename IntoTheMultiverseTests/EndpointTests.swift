//
//  EndpointTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/8/22.
//

import XCTest
@testable import IntoTheMultiverse

final class EndpointTests: XCTestCase {
    
    // MARK: - Properties
    
    private let mockApiPrivateKey = "1234"
    private let mockApiPublicKey = "5678"
    private let expectedHash = "bba72afa613b1938b9823bb39e7c0243"
    private let date = Date(timeIntervalSince1970: 10)
    private var timestamp: String {
        String(date.timeIntervalSince1970)
    }
    private var queryItems: [URLQueryItem]!
    
    // MARK: - Set up and tear down
    
    override func setUp() async throws {
        queryItems = try Endpoint.buildRequiredQueryItems(for: date, privateKey: mockApiPrivateKey, publicKey: mockApiPublicKey)
    }
    
    override func tearDown() async throws {
        queryItems.removeAll()
    }
    
    // MARK: - Tests
    
    func testComicCharactersEndpoint() {
        // Act
        let endpoint = Endpoint.comicCharacters(with: queryItems)
        
        // Assert
        let expectedUrl = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=\(timestamp)&apikey=\(mockApiPublicKey)&hash=\(expectedHash)")
        XCTAssertEqual(endpoint.url, expectedUrl)
    }
    
    func testComicCharacterDetailEndpoint() {
        // Arrange
        let characterId = 4
        
        // Act
        let endpoint = Endpoint.comicCharacter(for: characterId, with: queryItems)
        
        // Assert
        let expectedUrl = URL(string: "https://gateway.marvel.com/v1/public/characters/\(characterId)?ts=\(timestamp)&apikey=\(mockApiPublicKey)&hash=\(expectedHash)")
        XCTAssertEqual(endpoint.url, expectedUrl)
    }
}

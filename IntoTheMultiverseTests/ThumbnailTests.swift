//
//  ThumbnailTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/9/22.
//

import XCTest
@testable import IntoTheMultiverse

final class ThumbnailTests: XCTestCase {
    
    // MARK: - Tests
    
    func testThumbnailUrl() {
        // Arrange
        let path = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        let fileExtension = "jpg"
        let thumbnail = Thumbnail(path: path, fileExtension: fileExtension)
        
        // Act
        let url = thumbnail.url(for: .original)
        
        // Assert
        XCTAssertEqual(url, URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
    }
    
    func testThumbnailUrlForCustomSize() {
        // Arrange
        let path = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        let fileExtension = "jpg"
        let thumbnail = Thumbnail(path: path, fileExtension: fileExtension)
        
        // Act
        let url = thumbnail.url(for: .squareMedium)
        
        // Assert
        XCTAssertEqual(url, URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784/standard_medium.jpg"))
    }
}

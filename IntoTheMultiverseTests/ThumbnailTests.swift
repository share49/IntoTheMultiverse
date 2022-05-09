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
        // Arange
        let path = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784"
        let fileExtension = "jpg"
        let thumbnail = Thumbnail(path: path, fileExtension: fileExtension)
        
        // Assert
        XCTAssertEqual(thumbnail.url, URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
    }
}

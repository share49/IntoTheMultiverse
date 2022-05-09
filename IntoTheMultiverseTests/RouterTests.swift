//
//  RouterTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/9/22.
//

import XCTest
@testable import IntoTheMultiverse

final class RouterTests: XCTestCase {
    
    // MARK: - Tests
    
    func testRouter() {
        // Arange
        let navigationController = UINavigationController(rootViewController: UIViewController())
        
        // Act
        Router(navigationController).navigate(to: .characterDetail(characterId: 4), animated: false)
        
        // Assert
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        let presentedVC = navigationController.viewControllers.last!
        XCTAssert(presentedVC is CharacterDetailViewController)
    }
}

//
//  CoordinatorTests.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/9/22.
//

import XCTest
@testable import IntoTheMultiverse

final class CoordinatorTests: XCTestCase {
    
    // MARK: - Tests
    
    func testCoordinatorStart() {
        // Arrange
        let navigationController = UINavigationController()
        let coordinator = MainCoordinator(navigationController: navigationController)
        
        // Act
        coordinator.start()
        
        // Assert
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        let presentedVC = navigationController.viewControllers.last!
        XCTAssert(presentedVC is CharactersViewController)
    }
    
    func testNavigateToCharacterDetailVC() {
        // Arrange
        let navigationController = UINavigationController()
        let coordinator = MainCoordinator(navigationController: navigationController)
        let logger = MLogger()
        
        // Act
        coordinator.characterDetail(characterId: 0, persistenceManager: PersistenceManager(with: logger), logger: logger)
        
        // Assert
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        let presentedVC = navigationController.viewControllers.last!
        XCTAssert(presentedVC is CharacterDetailViewController)
    }
}

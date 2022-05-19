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
        // Arrange
        let navigationController = UINavigationController(rootViewController: UIViewController())
        let presistanceManager = MockPersistenceManager()
        let viewModel = CharacterDetailViewModel(characterId: 4, persistenceManager: presistanceManager)
        
        // Act
        Router(navigationController).navigate(to: .characterDetail(viewModel: viewModel), animated: false)
        
        // Assert
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        let presentedVC = navigationController.viewControllers.last!
        XCTAssert(presentedVC is CharacterDetailViewController)
    }
}

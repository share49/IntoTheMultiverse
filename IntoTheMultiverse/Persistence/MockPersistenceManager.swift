//
//  MockPersistenceManager.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/19/22.
//

import Foundation

struct MockPersistenceManager {
    
    // MARK: - Properties
    
    let mockIsFavorite: Bool
}

// MARK: - PersistenceHandler

extension MockPersistenceManager: PersistenceHandler {
    
    func isFavorite(_ id: Int) -> Bool {
        mockIsFavorite
    }
    
    func saveFavoriteState(_ isFavorite: Bool, for id: Int) throws {
    }
}

//
//  MockPersistenceManager.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/19/22.
//

import Foundation

struct MockPersistenceManager {
    
}

// MARK: - PersistenceHandler

extension MockPersistenceManager: PersistenceHandler {
    
    func isFavorite(_ id: Int) -> Bool {
        true
    }
    
    func saveFavoriteState(for id: Int, isFavorite: Bool) throws {
    }
}

//
//  MockPersistenceManager.swift
//  IntoTheMultiverseTests
//
//  Created by Roger Pintó Diaz on 5/19/22.
//

import Foundation

struct MockPersistenceManager {
    
    // MARK: - Properties
    
    let stubIsFavorite: Bool
}

// MARK: - PersistenceHandler

extension MockPersistenceManager: PersistenceHandler {
    
    func isFavorite(_ id: Int) -> Bool {
        stubIsFavorite
    }
    
    func saveFavoriteState(_ isFavorite: Bool, for id: Int) throws {
    }
}

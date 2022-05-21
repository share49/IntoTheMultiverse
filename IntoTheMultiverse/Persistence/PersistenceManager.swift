//
//  PersistenceManager.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/18/22.
//

import Foundation
import CoreData

protocol PersistenceHandler {
    func isFavorite(_ id: Int) -> Bool
    func saveFavoriteState(for id: Int, isFavorite: Bool) throws
}

struct PersistenceManager {
    
    // MARK: - Properties
    
    private let container: NSPersistentContainer
    private let logger: LogHandler
    
    // MARK: - Initializer
    
    init(with logger: LogHandler) {
        self.logger = logger
        
        container = NSPersistentContainer(name: "Persistence")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

// MARK: - PersistenceHandler

extension PersistenceManager: PersistenceHandler {
    
    func isFavorite(_ id: Int) -> Bool {
        fetchFavoriteCoreDataObject(for: id, in: container.viewContext)?.isFavorite ?? false
    }
    
    func saveFavoriteState(for id: Int, isFavorite: Bool) throws {
        let context = container.viewContext
        
        if let favorite = fetchFavoriteCoreDataObject(for: id, in: context) {
            favorite.isFavorite = isFavorite
        } else {
            let cdFavorite = CDFavorite(context: context)
            cdFavorite.id = Int32(id)
            cdFavorite.isFavorite = isFavorite
        }
        
        try context.save()
    }
    
    // MARK: - Support methods
    
    private func fetchFavoriteCoreDataObject(for id: Int, in context: NSManagedObjectContext) -> CDFavorite? {
        let fetchRequest: NSFetchRequest<CDFavorite> = CDFavorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites.first
        } catch {
            logger.error("Unable to execute fetch request, \(error)")
        }
        
        return nil
    }
}

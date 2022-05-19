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
    
    let container: NSPersistentContainer
    
    // MARK: - Initializer
    
    init() {
        container = NSPersistentContainer(name: "Persistence")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                NSLog("Error loading persistent store. \(error), \(error.userInfo)")
            }
        })
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
            let cdFavorite = Favorite(context: context)
            cdFavorite.id = Int32(id)
            cdFavorite.isFavorite = isFavorite
        }
        
        try context.save()
    }
    
    // MARK: - Support methods
    
    private func fetchFavoriteCoreDataObject(for id: Int, in context: NSManagedObjectContext) -> Favorite? {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.first
        } catch {
            NSLog("Unable to execute fetch request, \(error)")
        }
        
        return nil
    }
}

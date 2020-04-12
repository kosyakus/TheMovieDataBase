//
//  CoreDataRepository.swift
//  TheMovieDatabaseDBLayer
//
//  Created by Natali on 12.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import CoreData
import Foundation

public class CoreDataRepository<RepositoryObject>: CDRepository
        where RepositoryObject: CDEntity,
        RepositoryObject.StoreType: NSManagedObject,
        RepositoryObject.StoreType.EntityObject == RepositoryObject {

    var persistentContainer: NSPersistentContainer

    public init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    public func getAll(where predicate: NSPredicate?) throws -> [RepositoryObject] {
        let objects = try getManagedObjects(with: predicate)
        return objects.compactMap { $0.model }
    }

    public func insert(item: RepositoryObject) throws {
        persistentContainer.viewContext.insert(item.toStorable(in: persistentContainer.viewContext))
        saveContext()
    }
    
    public func update(item: RepositoryObject) throws {
        try delete(item: item)
        try insert(item: item)
    }
    
    public func delete(item: RepositoryObject) throws {
        let predicate = NSPredicate(format: "uuid == %@", item.toStorable(in: persistentContainer.viewContext).uuid)
        let items = try getManagedObjects(with: predicate)

        persistentContainer.viewContext.delete(items.first!)
        saveContext()
    }
    
    public func deleteAll() throws {
        // Create Fetch Request
        let entityName = String(describing: RepositoryObject.StoreType.self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let context = persistentContainer.viewContext
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(batchDeleteRequest)
    }
    
    private func getManagedObjects(with predicate: NSPredicate?) throws -> [RepositoryObject.StoreType] {
        let entityName = String(describing: RepositoryObject.StoreType.self)
        let request = NSFetchRequest<RepositoryObject.StoreType>(entityName: entityName)
        request.predicate = predicate
        
        return try persistentContainer.viewContext.fetch(request)
    }
    
    // MARK: - Core Data Saving support
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//
//  CoreDataHelper.swift
//  TheMovieDatabaseDBLayerTests
//
//  Created by Natali on 14.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import CoreData
import Foundation

class CoreDataHelper {
    static let managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: CoreDataHelper()))] )!
        return managedObjectModel
    }()
    
    static let shared = CoreDataHelper()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { [weak self] storeDescription, error in
            if let error = error {
                NSLog("CoreData error \(error), \(String(describing: error._userInfo))")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let context: NSManagedObjectContext = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
}

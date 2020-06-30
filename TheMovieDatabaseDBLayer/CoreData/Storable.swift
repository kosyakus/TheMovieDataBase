//
//  Storable.swift
//  TheMovieDatabaseDBLayer
//
//  Created by Natali on 12.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import CoreData
import Foundation

extension CDStorable where Self: NSManagedObject {
    
    static func getOrCreateSingle(with uuid: String, from context: NSManagedObjectContext) -> Self {
        let result = single(with: uuid, from: context) ?? insertNew(in: context)
        result.setValue(uuid, forKey: "uuid")
        return result
    }
    
    static func single(with uuid: String, from context: NSManagedObjectContext) -> Self? {
        fetch(with: uuid, from: context)?.first
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self {
        Self(context: context)
    }
    
    static func fetch(with uuid: String, from context: NSManagedObjectContext) -> [Self]? {
        let entityName = String(describing: Self.self)
        let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", uuid)
        fetchRequest.fetchLimit = 1

        let result: [Self]? = try? context.fetch(fetchRequest)
        
        return result
    }
}

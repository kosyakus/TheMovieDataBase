//
//  Repository.swift
//  TheMovieDatabaseDBLayer
//
//  Created by Natali on 12.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import CoreData
import Foundation

protocol CDRepository {
    associatedtype EntityObject: CDEntity
    
    func getAll(where predicate: NSPredicate?) throws -> [EntityObject]
    func insert(item: EntityObject) throws
    func update(item: EntityObject) throws
    func delete(item: EntityObject) throws
}

extension CDRepository {
    func getAll() throws -> [EntityObject] {
        try getAll(where: nil)
    }
}

public protocol CDEntity {
    associatedtype StoreType: CDStorable
    
    func toStorable(in context: NSManagedObjectContext) -> StoreType
}

public protocol CDStorable {
    associatedtype EntityObject: CDEntity
    
    var model: EntityObject { get }
    var uuid: String { get }
}

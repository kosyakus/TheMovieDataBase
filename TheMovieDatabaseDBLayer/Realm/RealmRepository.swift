//
//  RealmRepository.swift
//  TheMovieDatabaseDBLayer
//
//  Created by Natali on 12.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import RealmSwift

public class AnyRepository<RepositoryObject>: Repository
    where RepositoryObject: Entity,
RepositoryObject.StoreType: Object {
    
    public typealias RealmObject = RepositoryObject.StoreType
    
    private let realm: Realm
    
    public init() {
        // swiftlint:disable:next force_try
        realm = try! Realm()
    }
    
    public func getAll(where predicate: NSPredicate?) -> [RepositoryObject] {
        var objects = realm.objects(RealmObject.self)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        return objects.compactMap { ($0).model as? RepositoryObject }
    }
    
    public func insert(item: RepositoryObject) throws {
        try realm.write {
            realm.add(item.toStorable())
        }
    }
    
    public func update(item: RepositoryObject) throws {
        try delete(item: item)
        try insert(item: item)
    }
    
    public func delete(item: RepositoryObject) throws {
        try realm.write {
            let predicate = NSPredicate(format: "uuid == %@", item.toStorable().uuid)
            if let productToDelete = realm.objects(RealmObject.self)
                .filter(predicate).first {
                realm.delete(productToDelete)
            }
        }
    }
    
    public func deleteAll() throws {
        try realm.write {
            let productToDelete = realm.objects(RealmObject.self)
            realm.delete(productToDelete)
        }
    }
}

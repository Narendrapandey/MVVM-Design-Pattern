//
//  Repository.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//

import Foundation
import CoreData

// MARK: - CRUD Functions -
protocol Repository {
    associatedtype EntityObject: Entity
    
    func getAll(where predicate: NSPredicate?) throws -> [EntityObject]
    func insert(item: EntityObject) throws
    func update(item: EntityObject) throws
    func delete(item: EntityObject, with predicate: NSPredicate?) throws
}

// MARK: - Get repo's Entity -
extension Repository {
    func getAll() throws -> [EntityObject] {
        return try getAll(where: nil)
    }
}

// MARK: - Convert to storable type -
protocol Entity {
    associatedtype StoreType: Storable
    
    func toStorable(in context: NSManagedObjectContext,
                    withSuperClass superClass: NSManagedObject?) -> StoreType?
}

// MARK: - get Storable Data -
protocol Storable {
    associatedtype EntityObject: Entity
    
    var model: EntityObject { get }
    var primaryKey: String { get }
}


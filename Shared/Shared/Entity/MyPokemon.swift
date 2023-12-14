//
//  MyPokemon.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 13/12/23.
//

import Foundation
import CoreData

@objc(MyPokemon)
public class MyPokemon: NSManagedObject {
}

extension MyPokemon {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyPokemon> {
        return NSFetchRequest<MyPokemon>(entityName: "MyPokemon")
    }
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var nickname: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var count: Int16
    @NSManaged public var postFix: Int16
    @NSManaged public var dateCreated: Date?
}

extension MyPokemon: Identifiable {
}

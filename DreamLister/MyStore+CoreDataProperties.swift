//
//  MyStore+CoreDataProperties.swift
//  DreamLister
//
//  Created by Мулярчук Константин on 18.06.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import Foundation
import CoreData


extension MyStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyStore> {
        return NSFetchRequest<MyStore>(entityName: "MyStore")
    }

    @NSManaged public var storeName: String?
    @NSManaged public var toImage: MyImage?
    @NSManaged public var toItem: NSSet?

}

// MARK: Generated accessors for toItem
extension MyStore {

    @objc(addToItemObject:)
    @NSManaged public func addToToItem(_ value: MyItem)

    @objc(removeToItemObject:)
    @NSManaged public func removeFromToItem(_ value: MyItem)

    @objc(addToItem:)
    @NSManaged public func addToToItem(_ values: NSSet)

    @objc(removeToItem:)
    @NSManaged public func removeFromToItem(_ values: NSSet)

}

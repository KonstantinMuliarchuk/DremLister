//
//  MyImage+CoreDataProperties.swift
//  DreamLister
//
//  Created by Мулярчук Константин on 18.06.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import Foundation
import CoreData


extension MyImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyImage> {
        return NSFetchRequest<MyImage>(entityName: "MyImage")
    }

    @NSManaged public var imageToItem: NSObject?
    @NSManaged public var toItem: MyItem?
    @NSManaged public var toStore: NSSet?

}

// MARK: Generated accessors for toStore
extension MyImage {

    @objc(addToStoreObject:)
    @NSManaged public func addToToStore(_ value: MyStore)

    @objc(removeToStoreObject:)
    @NSManaged public func removeFromToStore(_ value: MyStore)

    @objc(addToStore:)
    @NSManaged public func addToToStore(_ values: NSSet)

    @objc(removeToStore:)
    @NSManaged public func removeFromToStore(_ values: NSSet)

}

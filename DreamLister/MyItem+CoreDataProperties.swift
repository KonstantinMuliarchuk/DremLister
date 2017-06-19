//
//  MyItem+CoreDataProperties.swift
//  DreamLister
//
//  Created by Мулярчук Константин on 18.06.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import Foundation
import CoreData


extension MyItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyItem> {
        return NSFetchRequest<MyItem>(entityName: "MyItem")
    }

    @NSManaged public var detailsAbout: String?
    @NSManaged public var itemCreated: NSDate?
    @NSManaged public var itemPrice: Double
    @NSManaged public var itemTitle: String?
    @NSManaged public var toImage: MyImage?
    @NSManaged public var toItemType: MyItemType?
    @NSManaged public var toStore: MyStore?

}

//
//  MyItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Мулярчук Константин on 18.06.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import Foundation
import CoreData


extension MyItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyItemType> {
        return NSFetchRequest<MyItemType>(entityName: "MyItemType")
    }

    @NSManaged public var itemType: String?
    @NSManaged public var toItem: MyItem?

}

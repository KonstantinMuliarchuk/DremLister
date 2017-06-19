//
//  MyItem+CoreDataClass.swift
//  DreamLister
//
//  Created by Мулярчук Константин on 18.06.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import Foundation
import CoreData

@objc(MyItem)
public class MyItem: NSManagedObject {

    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        
        self.itemCreated = NSDate()
    }
    
}

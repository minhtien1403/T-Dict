//
//  ListItem+CoreDataClass.swift
//  T-Dict
//
//  Created by Tiến on 4/1/21.
//  Copyright © 2021 Tiến. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ListItem)
public class ListItem: NSManagedObject {

}

extension ListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListItem> {
        return NSFetchRequest<ListItem>(entityName: "ListItem")
    }

    @NSManaged public var word: String?
    @NSManaged public var pronounce: String?
    @NSManaged public var parentList: String?
}

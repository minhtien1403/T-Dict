//
//  List+CoreDataClass.swift
//  T-Dict
//
//  Created by Tiến on 4/1/21.
//  Copyright © 2021 Tiến. All rights reserved.
//
//

import Foundation
import CoreData

@objc(List)
public class List: NSManagedObject {

}

extension List {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var name: String?
    @NSManaged public var icon: String?
}


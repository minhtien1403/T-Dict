//
//  CoreDataManager.swift
//  T-Dict
//
//  Created by Tiến on 4/1/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    let context = CoreDataServices.shared.persistentContainer.viewContext
    
    struct ListManager {
        static let shared = CoreDataManager.ListManager()
        
        private init() {}
    }
    
    struct ListItemManager {
        static let shared = CoreDataManager.ListItemManager()
        
        private init() {}
    }
}

//
//  CoreDataManager.List.swift
//  T-Dict
//
//  Created by Tiến on 4/1/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Then

extension CoreDataManager.ListManager {
    
    func fetchAllList() -> [List] {
        do {
            let lists = try CoreDataManager.shared.context.fetch(List.fetchRequest()) as? [List]
            return lists ?? [List]()
        } catch {
            print(error.localizedDescription)
            return [List]()
        }
    }
    
    func addNewList(name: String, icon: String) {
        let _ = List(context: CoreDataManager.shared.context).then {
            $0.name = name
            $0.icon = icon
        }
        do {
            try CoreDataManager.shared.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteList(list: List) {
        CoreDataManager.shared.context.delete(list)
        do {
            try CoreDataManager.shared.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

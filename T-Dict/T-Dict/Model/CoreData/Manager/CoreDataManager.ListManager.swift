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
    
    func addNewList(name: String, icon: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        do {
            let check = try CoreDataManager.shared.context.fetch(fetchRequest)
            if check.isEmpty {
                let _ = List(context: CoreDataManager.shared.context).then {
                    $0.name = name
                    $0.icon = icon
                }
                try CoreDataManager.shared.context.save()
                return true
            } else {
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func deleteList(list: List) {
        let items = CoreDataManager.ListItemManager.shared.fetchAllItemInList(listName: list.name ?? "")
        for item in items {
            CoreDataManager.ListItemManager.shared.deleteItem(item: item)
        }
        CoreDataManager.shared.context.delete(list)
        do {
            try CoreDataManager.shared.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

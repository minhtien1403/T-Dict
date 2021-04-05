//
//  CoreDataManager+ListItemManager.swift
//  T-Dict
//
//  Created by Tiến on 4/2/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Then

extension CoreDataManager.ListItemManager {
    
    func addItemToList(word: String, pronounce: String, listName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ListItem")
        fetchRequest.predicate = NSPredicate(format: "word = %@ AND parentList = %@ ", word, listName )
        do {
            let check = try CoreDataManager.shared.context.fetch(fetchRequest)
            if check.isEmpty {
                let _ = ListItem(context: CoreDataManager.shared.context).then {
                    $0.word = word
                    $0.pronounce = pronounce
                    $0.parentList = listName
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
    
    func fetchAllItemInList(listName: String) -> [ListItem] {
        do {
            let request = ListItem.fetchRequest() as NSFetchRequest<ListItem>
            let pred = NSPredicate(format: "parentList == %@", listName)
            request.predicate = pred
            return try CoreDataManager.shared.context.fetch(request)
        } catch {
            print(error.localizedDescription)
            return [ListItem]()
        }
    }
    
    func deleteItem(item: ListItem) {
        CoreDataManager.shared.context.delete(item)
        do {
            try CoreDataManager.shared.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

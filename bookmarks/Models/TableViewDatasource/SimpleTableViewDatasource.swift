//
//  TableViewDatasource.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation
import UIKit

class SimpleTableViewDataSource<T>: NSObject, UITableViewDataSource {
    
    let items: [T]
    let reuseIdentifier: (IndexPath) -> (String)
    let configureCell: (UITableViewCell, T, IndexPath) -> (UITableViewCell)
    
    let canRemoveItem: (IndexPath) -> (Bool)
    let removeItem: (IndexPath) -> Void
    
    required init(_ items: [T],
                  reuseIdentifier: @escaping (IndexPath)->(String),
                  configureCell: @escaping (UITableViewCell, T, IndexPath) -> (UITableViewCell),
                  canRemoveItem: @escaping (IndexPath) -> (Bool),
                  removeItem: @escaping (IndexPath) -> Void) {
        self.items = items
        self.reuseIdentifier = reuseIdentifier
        self.configureCell = configureCell
        self.canRemoveItem = canRemoveItem
        self.removeItem = removeItem
        super.init()
    }
    
    func item(at indexPath: IndexPath) -> T? {
        guard indexPath.section == 0,
            indexPath.row >= 0,
            indexPath.row < items.count else { return nil }
        return items[indexPath.row]
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = self.item(at: indexPath) else { fatalError() }
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier(indexPath), for: indexPath)
        return configureCell(cell, item, indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return canRemoveItem(indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(indexPath)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

extension SimpleTableViewDataSource {
    convenience init(items: [T], reuseIdentifier: String, configureCell: @escaping (UITableViewCell, T, IndexPath) -> (UITableViewCell), canRemoveItem: @escaping (IndexPath) -> (Bool), removeItem: @escaping (IndexPath) -> Void) {
        self.init(items, reuseIdentifier: { _ in return reuseIdentifier}, configureCell: configureCell, canRemoveItem: canRemoveItem, removeItem: removeItem)
    }
}

//
//  UserDefaultsBookmarkStorage.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation

final class UserDefaultsBookmarkStorage: NSObject {
    
    let userDefaults: UserDefaults
    
    static let bookmarksKey = "UserDefaultsBookmarkStorage.bookmarks"
    var bookmarks: [Bookmark] {
        didSet {
            let encoded = try? JSONEncoder().encode(bookmarks)
            userDefaults.set(encoded, forKey: UserDefaultsBookmarkStorage.bookmarksKey)
            onChange?()
        }
    }
    var onChange: (() -> Void)?
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        if let bookmarksData = userDefaults.object(forKey: UserDefaultsBookmarkStorage.bookmarksKey) as? Data,
            let bookmarks = try? JSONDecoder().decode(Array<Bookmark>.self, from: bookmarksData) {
            self.bookmarks = bookmarks
        } else {
            self.bookmarks = []
        }
    }
}

extension UserDefaultsBookmarkStorage: BookmarkStorage {
    
    var count: Int {
        return bookmarks.count
    }
    
    func add(_ bookmark: Bookmark) {
        let newArray = bookmarks + [bookmark]
        let sorted = newArray.sorted() { $0.createdAt > $1.createdAt }
        bookmarks = sorted
    }
    
    func remove(_ bookmark: Bookmark) {
        bookmarks = bookmarks.filter({ $0.uuid != bookmark.uuid }) // improve: stop after we found the one we want to remove
    }
    
    func update(_ bookmark: Bookmark) {
        remove(bookmark)
        add(bookmark)
    }
    
    func bookmark(atIndex index: Int) -> Bookmark? {
        guard index < bookmarks.count else { return nil }
        return bookmarks[index]
    }
    
    func bookmark(with url: URL) -> Bookmark? {
        return bookmarks.first() { $0.url == url }
    }
}

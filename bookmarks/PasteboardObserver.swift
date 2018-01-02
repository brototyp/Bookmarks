//
//  PasteboardObserver.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation

final class PasteboardObserver {
    let pasteboard: Pasteboard
    let storage: BookmarkStorage
    let bookmarkUpdater = BookmarkUpdater()
    
    init(pasteboard: Pasteboard, storage: BookmarkStorage) {
        self.pasteboard = pasteboard
        self.storage = storage
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pasteboardChanged), name: .UIPasteboardChanged, object: nil)
    }
    
    /// TODO: Follow HTTP redirects before adding the url
    func addUrlFromPastboard() {
        if let url = pasteboard.url(), storage.bookmark(with: url) == nil {
            let bookmark = Bookmark(url)
            storage.add(bookmark)
            bookmarkUpdater.update(bookmark) { result in
                switch result {
                case .success(let bookmark): self.storage.update(bookmark)
                case .error(let error): return /// TODO: add error handling
                }
            }
        }
    }
    
    @objc func applicationDidBecomeActive() {
        addUrlFromPastboard()
    }
    
    @objc func pasteboardChanged() {
        addUrlFromPastboard()
    }
}

//
//  Library.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation

protocol BookmarkStorage: NSObjectProtocol {
    var bookmarks: [Bookmark] { get }
    var count: Int { get }
    
    func update(_ bookmark: Bookmark)
    
    func add(_ bookmark: Bookmark)
    func remove(_ bookmark: Bookmark)
    
    func bookmark(atIndex index: Int) -> Bookmark?
    func bookmark(with url: URL) -> Bookmark?
    
    /// TODO: Use a better observer pattern here
    var onChange: (()->Void)? { get set }
}

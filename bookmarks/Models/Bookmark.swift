//
//  Bookmark.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation

struct Bookmark: Codable {
    let uuid: UUID
    let url: URL
    let createdAt: Date
    
    let title: String?
    let content: Data?
}

extension Bookmark {
    init(_ url: URL) {
        uuid = UUID()
        self.url = url
        createdAt = Date()
        title = nil
        content = nil
    }
}

extension Bookmark: Equatable {
    static func == (lhs: Bookmark, rhs: Bookmark) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

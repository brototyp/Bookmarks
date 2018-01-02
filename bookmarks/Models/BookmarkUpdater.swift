//
//  BookmarkUpdater.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation
import Kanna

final class BookmarkUpdater {
    let dataFetcher: DataFetcher = URLSessionDataFetcher()
    
    func update(_ bookmark: Bookmark, completion: @escaping (Result<Bookmark>)->()) {
        dataFetcher.data(for: bookmark.url) { result in
            switch result {
            case .error(let error): completion(.error(error))
            case .success(let data):
                if let doc = try? HTML(html: data, encoding: .utf8) {
                    var updatedBookmark = bookmark.setting(data: data)
                    if let title = doc.title {
                        updatedBookmark = updatedBookmark.setting(title: title.trimmingCharacters(in: .whitespacesAndNewlines))
                    }
                    if let content = doc.content {
                        updatedBookmark = updatedBookmark.setting(content: content)
                    }
                    completion(.success(updatedBookmark))
                } else {
                    completion(.error(BookmarkUpdaterError.unableToParseHtmlData))
                }
            }
        }
    }
}

enum BookmarkUpdaterError: Error {
    case unableToParseHtmlData
}

extension Bookmark {
    func setting(title: String?) -> Bookmark {
        return Bookmark(uuid: uuid, url: url, createdAt: createdAt, title: title, data: data, content: content)
    }
    func setting(content: String?) -> Bookmark {
        return Bookmark(uuid: uuid, url: url, createdAt: createdAt, title: title, data: data, content: content)
    }
    func setting(data: Data?) -> Bookmark {
        return Bookmark(uuid: uuid, url: url, createdAt: createdAt, title: title, data: data, content: content)
    }
}

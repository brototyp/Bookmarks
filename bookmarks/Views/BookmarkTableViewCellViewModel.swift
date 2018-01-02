//
//  BookmarkTableViewCellViewModel.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation
import Kanna

struct BookmarkTableViewCellViewModel {
    let faviconUrl: URL? /// TODO: the parsing of the favicon should be moved to the initial parsing of bookmarks
    let title: String
    let date: String
    let subtitle: String
    
    init(_ bookmark: Bookmark) {
        title = bookmark.url.host ?? ""
        subtitle = bookmark.title ?? ""
        date = BookmarkTableViewCell.dateFormatter.string(from: bookmark.createdAt)
        
        if let data = bookmark.data, let doc = try? HTML(html: data, encoding: .utf8),
            let urlString = doc.faviconUrl,
            let url = URL(string: urlString, relativeTo: bookmark.url){
            faviconUrl = url
        } else {
            faviconUrl = nil
        }
    }
}

extension BookmarkTableViewCell {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
}

extension HTMLDocument {
    var faviconUrl: String? {
        let faviconXPaths = ["//head//link[@rel='apple-touch-icon']/attribute::href", "//head//link[@rel='shortcut icon']/attribute::href", "//head//link[@rel='icon']/attribute::href"]
        for path in faviconXPaths {
            if let string = xpath(path).first?.content,
                string.hasSuffix(".png") {
                return string
            }
        }
        for path in faviconXPaths {
            if let string = xpath(path).first?.content {
                return string
            }
        }
        return nil
    }
}

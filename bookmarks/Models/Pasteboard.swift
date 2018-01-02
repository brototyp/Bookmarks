//
//  Pasteboard.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation
import UIKit

final class Pasteboard {
    let pasteboard = UIPasteboard.general
    
    // is this even necessary?
    public func url() -> URL? {
        if let url = pasteboard.url {
            return url
        }
        if let string = pasteboard.string,
            let url = URL(string: string) {
            return url
        }
        return nil
    }
}

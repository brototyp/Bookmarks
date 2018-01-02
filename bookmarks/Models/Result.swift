//
//  Result.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}

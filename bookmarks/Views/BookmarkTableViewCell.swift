//
//  BookmarkTableViewCell.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation
import UIKit

final class BookmarkTableViewCell: UITableViewCell {
    @IBOutlet var faviconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        faviconImageView.image = nil
    }
}

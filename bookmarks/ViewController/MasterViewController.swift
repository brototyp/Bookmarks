//
//  MasterViewController.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var detailViewController: DetailViewController? = nil
    public var bookmarkStorage: BookmarkStorage? = nil {
        didSet {
            guard let bookmarkStorage = bookmarkStorage else { return }
            dataSource = SimpleTableViewDataSource.dataSource(for: bookmarkStorage)
            bookmarkStorage.onChange = {
                self.dataSource = SimpleTableViewDataSource.dataSource(for: bookmarkStorage)
            }
        }
    }
    private var dataSource: SimpleTableViewDataSource<Bookmark>? = nil {
        didSet {
            DispatchQueue.main.async {
                /// TODO: calculate the diff and update animated instead
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            }
        }
    }
    let pasteboard = Pasteboard()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow, let bookmark = dataSource?.item(at: indexPath) {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = bookmark
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

extension SimpleTableViewDataSource where T == Bookmark {
    static func dataSource(for bookmarkStorage: BookmarkStorage) -> SimpleTableViewDataSource {
        return SimpleTableViewDataSource(items: bookmarkStorage.bookmarks, reuseIdentifier: "Cell", configureCell: { cell, bookmark, _ in
            guard let bookmarkCell = cell as? BookmarkTableViewCell else { return cell }
            let viewModel = BookmarkTableViewCellViewModel(bookmark)
            bookmarkCell.titleLabel.text = viewModel.title
            bookmarkCell.subtitleLabel.text = viewModel.subtitle
            bookmarkCell.dateLabel.text = viewModel.date
            if let faviconUrl = viewModel.faviconUrl {
                bookmarkCell.faviconImageView.setImage(from: faviconUrl)
            }
            return cell
        }, canRemoveItem: { _ in return true}, removeItem: { [weak bookmarkStorage] indexPath in
            if let bookmark = bookmarkStorage?.bookmark(atIndex: indexPath.row) {
                bookmarkStorage?.remove(bookmark)
            }
        })
    }
}
extension UIImageView {
    /// TODO: replace with proper, cancelable method
    /// TODO: add fallback image
    public func setImage(from url: URL) {
        image = nil
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print("\(error)")
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data!)
                self.image = image
            }
        }).resume()
    }
}

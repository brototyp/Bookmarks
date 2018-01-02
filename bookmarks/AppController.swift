//
//  AppController.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation
import UIKit

final class AppController {
    
    var appDelegate: AppDelegate { return UIApplication.shared.delegate! as! AppDelegate }
    var window: UIWindow { return appDelegate.window! }
    var splitViewControllerManager: SplitViewControllerManager!
    var bookmarksListViewController: MasterViewController {
        return splitViewControllerManager.masterViewController.viewControllers[0] as! MasterViewController
    }
    let bookmarkStorage: BookmarkStorage = UserDefaultsBookmarkStorage()
    var pasteboardObserver: PasteboardObserver! = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let splitViewController = window.rootViewController as! UISplitViewController
        splitViewControllerManager = SplitViewControllerManager(splitViewController)
        splitViewControllerManager.setup()
        bookmarksListViewController.bookmarkStorage = bookmarkStorage
        pasteboardObserver = PasteboardObserver(pasteboard: Pasteboard(), storage: bookmarkStorage)
        return true
    }
    
}


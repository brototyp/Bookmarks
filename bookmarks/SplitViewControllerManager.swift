//
//  SplitViewControllerManager.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import Foundation
import UIKit

final class SplitViewControllerManager {
    let splitViewController: UISplitViewController
    
    var masterViewController: UINavigationController { return splitViewController.viewControllers[0] as! UINavigationController }
    var navigationController: UINavigationController { return splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController }
    
    init(_ splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
    }
    
    public func setup() {
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
    }
}

extension SplitViewControllerManager: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}

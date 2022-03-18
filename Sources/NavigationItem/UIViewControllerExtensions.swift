//
//  UIViewControllerExtensions.swift
//  NavigationItem
//
//  Created by David Walter on 12.03.22.
//

import UIKit

extension UIViewController {
    func navigationController() -> UINavigationController? {
        guard let navigationController = navigationController else {
            return siblingNavigationController()
        }
        
        return navigationController
    }
    
    private func siblingNavigationController() -> UINavigationController? {
        guard let parent = parent,
              let entryIndex = parent.children.firstIndex(of: self),
              entryIndex > 0 else {
            return nil
        }
        
        for child in parent.children[0 ..< entryIndex].reversed() {
            if let navigationController = child.findNavigationController() {
                return navigationController
            }
        }
        
        return nil
    }
    
    private func findNavigationController() -> UINavigationController? {
        for child in children {
            if let navigationController = child as? UINavigationController {
                return navigationController
            } else if let navigationController = child.findNavigationController() {
                return navigationController
            }
        }
        
        return self as? UINavigationController
    }
}

//
//  UIViewControllerExtensions.swift
//  NavigationItem
//
//  Created by David Walter on 12.03.22.
//

import UIKit

extension UIViewController {
    func siblingNavigationController() -> UINavigationController? {
        guard let parent = self.parent,
              let entryIndex = parent.children.firstIndex(of: self),
              entryIndex > 0 else {
            return nil
        }
        
        for child in parent.children[0..<entryIndex].reversed() {
            if let typed = child.findNavigationController() {
                return typed
            }
        }
        
        return nil
    }
    
    func findNavigationController() -> UINavigationController? {
        for child in children {
            if let navigationController =  child as? UINavigationController {
                return navigationController
            } else {
                return child.findNavigationController()
            }
        }
        
        return self as? UINavigationController
    }
}

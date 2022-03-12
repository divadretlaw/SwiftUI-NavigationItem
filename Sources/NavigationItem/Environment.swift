//
//  Environment.swift
//  NavigationItem
//
//  Created by David Walter on 12.03.22.
//

import Foundation
import SwiftUI
import UIKit

struct NavigationControllerKey: EnvironmentKey {
    static var defaultValue: UINavigationController? {
        return nil
    }
}

extension EnvironmentValues {
    var navigationController: UINavigationController? {
        get {
            return self[NavigationControllerKey.self]
        }
        set {
            self[NavigationControllerKey.self] = newValue
        }
    }
}

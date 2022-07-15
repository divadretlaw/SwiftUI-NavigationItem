//
//  NavigationItem.swift
//  NavigationItem
//
//  Created by David Walter on 12.03.22.
//

import SwiftUI

extension View {
    /// Access the NavigationItem of the underlying `UINavigationController`
    ///
    /// Please attach `navigationItem()` or `navigationItem(customize:)` to your `NavigationView` or simply use `NavigationItemView`
    /// This will expose the underlying `UINavigationController` in the `Environment` for easier
    /// access.
    ///
    /// While the `NavigationItem` will still be found without this, it may be delayed or glitchy without this in certain situations.
    ///
    /// - Parameter customize: Callback with the found `UINavigationItem`
    public func navigationItem(customize: @escaping (UINavigationItem) -> Void) -> some View {
        modifier(NavigationControllerModifier(customize: customize))
    }
}

extension NavigationView {
    /// Access the NavigationItem of the underlying `UINavigationController` and expose it in the `Environment`
    ///
    /// - Parameter customize: Callback with the found `UINavigationItem`
    ///
    /// This is needed on the `NavigationView` in order to be able to expose the `UINavigationController` to all subviews
    public func navigationItem(customize: ((UINavigationItem) -> Void)?) -> some View {
        modifier(NavigationControllerModifier(customize: customize, forceEnvironment: true))
    }
    
    /// Expose the the NavigationItem of the underlying `UINavigationController` in the `Environment`
    ///
    /// While not strictly necessary to expose the the underlying `UINavigationController`
    /// in the `Environment` it is advised to do so as it heavily simplifies finding the `UINavigationController`. Without exposure accessing the NavigationItem might be slightly
    /// delayed and may cause glitches.
    ///
    /// This is needed on the `NavigationView` in order to be able to expose the `UINavigationController` to all subviews
    public func navigationItem() -> some View {
        modifier(NavigationControllerModifier(customize: nil, forceEnvironment: true))
    }
}

struct NavigationControllerModifier: ViewModifier {
    let customize: ((UINavigationItem) -> Void)?
    var forceEnvironment: Bool = false

    @Environment(\.navigationController) var navigationController
    @State private var holder: UINavigationController?
    
    func body(content: Content) -> some View {
        if !forceEnvironment, let navigationController = navigationController {
            content
                .onAppear {
                    if navigationController.children.count == 1 {
                        // RootViewContoller is still the visibleViewController, try again delayed
                        DispatchQueue.main.async {
                            guard let viewController = navigationController.visibleViewController else { return }
                            customize?(viewController.navigationItem)
                        }
                    } else {
                        guard let viewController = navigationController.visibleViewController else { return }
                        customize?(viewController.navigationItem)
                    }
                }
        } else {
            content
                .overlay(overlay)
                .environment(\.navigationController, holder)
        }
    }
    
    var overlay: some View {
        FindNavigationController {
            holder = $0
            callback()
        }
        .frame(width: 0, height: 0)
        .onAppear {
            callback()
        }
    }
    
    func callback() {
        DispatchQueue.main.async {
            guard let item = holder?.children.last?.navigationItem else { return }
            customize?(item)
        }
    }
}

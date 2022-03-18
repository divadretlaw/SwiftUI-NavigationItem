//
//  NavigationItem.swift
//  NavigationItem
//
//  Created by David Walter on 12.03.22.
//

import SwiftUI

extension View {
    public func navigationItem(customize: @escaping (UINavigationItem) -> Void) -> some View {
        modifier(NavigationControllerModifier(customize: customize))
    }
}

extension NavigationView {
    public func navigationItem(customize: @escaping (UINavigationItem) -> Void) -> some View {
        modifier(NavigationControllerModifier(customize: customize, forceEnvironment: true))
    }
}

struct NavigationControllerModifier: ViewModifier {
    let customize: (UINavigationItem) -> Void
    var forceEnvironment: Bool = false

    @Environment(\.navigationController) var navigationController
    @State private var holder: UINavigationController?
    
    func body(content: Content) -> some View {
        if !forceEnvironment, let navigationController = navigationController {
            content
                .onAppear {
                    guard let last = navigationController.children.last else { return }
                    
                    if last.children.isEmpty {
                        DispatchQueue.main.async {
                            guard let viewController = navigationController.children.last else { return }
                            customize(viewController.navigationItem)
                        }
                    } else {
                        guard let viewController = last.children.last else { return }
                        customize(viewController.navigationItem)
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
        }
        .frame(width: 0, height: 0)
        .onAppear {
            DispatchQueue.main.async {
                guard let item = holder?.visibleViewController?.navigationItem else { return }
                customize(item)
            }
        }
    }
}

//
//  NavigationItem.swift
//  NavigationItem
//
//  Created by David Walter on 12.03.22.
//

import SwiftUI

extension View {
    public func navigationItem(customize: @escaping (UINavigationItem) -> ()) -> some View {
        self.modifier(NavigationControllerModifier(customize: customize))
    }
}

struct NavigationControllerModifier: ViewModifier {
    let customize: (UINavigationItem) -> ()
    
    @Environment(\.navigationController) var navigationController
    
    @State private var holder: UINavigationController?
    
    func body(content: Content) -> some View {
        if let navigationController = navigationController {
            content
                .onAppear {
                    guard let last = navigationController.children.last else { return }
                    
                    if last.children.isEmpty {
                        DispatchQueue.main.async {
                            guard let navigationItem = navigationController.children.last?.navigationItem else { return }
                            customize(navigationItem)
                        }
                    } else {
                        guard let navigationItem = last.children.last?.navigationItem else { return }
                        customize(navigationItem)
                    }
                }
        } else {
            content
                .overlay(overlay)
                .environment(\.navigationController, holder)
        }
    }
    
    var overlay: some View {
        ViewControllerReader {
            if let navigationController = $0.navigationController {
                holder = navigationController
            } else {
                holder = $0.siblingNavigationController()
            }
        }
        .frame(width: 0, height: 0)
        .onAppear {
            DispatchQueue.main.async {
                guard let item = holder?.children.last?.navigationItem else { return }
                customize(item)
            }
        }
    }
}

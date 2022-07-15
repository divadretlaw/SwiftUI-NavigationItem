//
//  FindNavigationController.swift
//  NavigationItem
//
//  Created by David Walter on 12.03.22.
//

import SwiftUI
import UIKit

struct FindNavigationController: UIViewControllerRepresentable {
    var onUpdate: (UINavigationController?) -> Void
    
    func makeUIViewController(context: Context) -> InjectViewController {
        InjectViewController()
    }
    
    func updateUIViewController(_ uiViewController: InjectViewController, context: Context) {
        DispatchQueue.main.async {
            guard let viewController = uiViewController.navigationController() else {
                print("Warning: Attempting to access navigationItem without being attached to NavigationView. Please attach `.navigationItem()` to your NavigationView or this might fail.")
                DispatchQueue.main.async {
                    onUpdate(uiViewController.navigationController())
                }
                return
            }
            
            onUpdate(viewController)
        }
    }
}

class InjectViewController: UIViewController {
    required init() {
        super.init(nibName: nil, bundle: nil)
        view = InjectView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InjectView: UIView {
    required init() {
        super.init(frame: .zero)
        isHidden = true
        isUserInteractionEnabled = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

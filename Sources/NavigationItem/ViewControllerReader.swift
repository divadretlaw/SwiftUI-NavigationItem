//
//  ViewControllerReader.swift
//  NavigationItem
//
//  Created by David Walter on 12.03.22.
//

import SwiftUI
import UIKit

struct ViewControllerReader: UIViewControllerRepresentable {
    var onUpdate: (UIViewController) -> ()
    
    func makeUIViewController(context: Context) -> UIEmptyViewController {
        return UIEmptyViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIEmptyViewController, context: Context) {
        DispatchQueue.main.async {
            onUpdate(uiViewController)
        }
    }
}

class UIEmptyView: UIView {
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

class UIEmptyViewController: UIViewController {
    required init() {
        super.init(nibName: nil, bundle: nil)
        view = UIEmptyView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

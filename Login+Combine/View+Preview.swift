//
//  View+Preview.swift
//  Login+Combine
//
//  Created by 리아 on 2022/10/03.
//

import SwiftUI
import UIKit

extension UIViewController {

    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }

    func toPreview() -> some View {
        Preview(viewController: self)
    }
    
}

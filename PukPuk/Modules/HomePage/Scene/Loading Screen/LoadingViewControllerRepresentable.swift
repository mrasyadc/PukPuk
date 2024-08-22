//
//  LoadingViewControllerRepresentable.swift
//  PukPuk
//
//  Created by Filbert Chai on 15/08/24.
//

import SwiftUI

struct LoadingViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LoadingViewController {
        return LoadingViewController()
    }

    func updateUIViewController(_ uiViewController: LoadingViewController, context: Context) {
        // Leave this empty unless you need to update the view controller during SwiftUI updates.
    }
}

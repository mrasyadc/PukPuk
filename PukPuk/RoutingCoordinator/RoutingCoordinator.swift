//
//  RoutingCoordinator.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

import Foundation
import SwiftUI

enum Page: String, Identifiable {
    // MARK: Add Your Page Here

    // MARK: Example Data

    case home
    case loading
    case recommendation
    case record

    var id: String {
        self.rawValue
    }
}

enum Sheet: String, Identifiable {
    // MARK: Add Your Sheet Here

    // MARK: Example Data

    case testSheet

    var id: String {
        self.rawValue
    }
}

enum FullScreenCover: String, Identifiable {
    // MARK: Add Your Full Screen Cover Here

    // MARK: Example Data

    case testFullScreenCover

    var id: String {
        self.rawValue
    }
}

class RoutingCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?

    func push(page: Page) {
        self.path.append(page)
    }

    func present(sheet: Sheet) {
        self.sheet = sheet
    }

    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }

    func dismissSheet() {
        self.sheet = nil
    }

    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }

    func popToRoot() {
        self.path.removeLast(self.path.count)
    }

    func pop() {
        self.path.removeLast(1)
    }

    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .home:
            HomeView()
                .environmentObject(DependencyInjection.shared.homeViewModel())
        case .loading:
            LoadingViewControllerRepresentable()
                .toolbar(.hidden, for: .navigationBar)
                .ignoresSafeArea()
        case .record:
            RecordPageViewControllerWrapper()
                .edgesIgnoringSafeArea(.all)
        case .recommendation:
            ExampleView()
        }
    }

    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .testSheet:
            NavigationStack {
                TestSheet()
            }
        }
    }

    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .testFullScreenCover:
            NavigationStack {
                TestFullScreenCover()
            }
        }
    }
}

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
    case record
    case missRecord
    case onBoarding
    
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
    
    @Published var currentPageIndex: Int = 0
    let onboardingPages: [OnboardingPage] = [
        OnboardingPage(title: "Understand your baby’s world", description: "Record your baby’s cry and let Pukpuk identify it. For accurate analysis, avoid background noise or disturbances while recording your baby's cry.", heroImage: UIImage(resource: .iconHero1)),
        OnboardingPage(title: "Know what your baby wants", description: "Identify five cause of your baby’s cries: belly pain, burping, discomfort, hungry, and tired.", heroImage: UIImage(resource: .iconHero2)),
        OnboardingPage(title: "Ease of use", description: "Soothe your baby while controlling Pukpuk apps hands-free with Siri.", heroImage: UIImage(resource: .iconHero3))
    ]
    
    private var classificationResult: ClassificationResultEntity?
    
    init() {
        if !UserDefaults.standard.hasSeenOnboarding {
            self.push(page: .onBoarding)
        } else {
            self.push(page: .record)
        }
    }
    
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
                .toolbar(.hidden, for: .navigationBar)
        case .loading:
            LoadingViewControllerRepresentable()
                .toolbar(.hidden, for: .navigationBar)
                .ignoresSafeArea()
        case .record:
            RecordPageViewControllerWrapper()
                .toolbar(.hidden, for: .navigationBar)
                .edgesIgnoringSafeArea(.all)
        case .missRecord:
            NoResultViewControllerRepresentable()
                .edgesIgnoringSafeArea(.all)
        case .onBoarding:
            OnBoardingViewControllerRepresentable(
                pages: self.onboardingPages,
                currentPageIndex: Binding(
                    get: { self.currentPageIndex },
                    set: { newIndex in self.currentPageIndex = newIndex }
                ), coordinator: self
            )
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
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

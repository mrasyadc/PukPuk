//
//  HomeViewModel.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var modelResult: [String: Double] = ["A": 1.1]
    @Published var isNewOpen: Bool

    private let homeUseCase: HomeUseCaseProtocol

    init(homeUseCase: HomeUseCaseProtocol) {
        self.homeUseCase = homeUseCase
        self.isNewOpen = true
    }

    func checkAndGetModelResult() {
        if isNewOpen {
            firstOpenApp()
            isNewOpen = false
        }
    }

    func firstOpenApp() {
        modelResult = homeUseCase.getModelResult(url: URL(fileURLWithPath: "a"))
    }

    func refreshPage() {
        firstOpenApp()
    }
}

//
//  HomeViewModel.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var modelResult: [String: Double] = [:]
    @Published var isNewOpen: Bool
    @Published var errorText: String

    private let homeUseCase: HomeUseCaseProtocol

    init(homeUseCase: HomeUseCaseProtocol) {
        self.homeUseCase = homeUseCase
        self.isNewOpen = true
        self.errorText = ""
    }

    @MainActor
    func checkAndGetModelResult() async {
        if isNewOpen {
            await firstOpenApp()
            isNewOpen = false
        } else {
            await refreshPage()
        }
    }

    @MainActor
    func firstOpenApp() async {
        do {
            guard let url = Bundle.main.url(forResource: "542c", withExtension: "wav") else { return }

            modelResult = try await homeUseCase.getModelResult(url: url)
        } catch {
            errorText = error.localizedDescription
            print("failed in firstOpenApp()")
        }
    }

    @MainActor
    func refreshPage() async {
        await firstOpenApp()
    }
}

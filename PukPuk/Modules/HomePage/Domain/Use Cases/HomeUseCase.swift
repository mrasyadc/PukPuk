//
//  HomeUseCases.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

import Foundation

class HomeUseCase: HomeUseCaseProtocol {
    let homeRepository: HomeDefaultRepositoryProtocol

    init(homeRepository: HomeDefaultRepositoryProtocol) {
        self.homeRepository = homeRepository
    }

    func getModelResult(url: URL) async throws -> [String: Double] {
        return try await homeRepository.getModelResult(url: url)
    }
}

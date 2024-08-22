//
//  HomeDefaultRepository.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

import Foundation

class HomeDefaultRepository:
    HomeDefaultRepositoryProtocol
{
    private let homeLocalDataSource: HomeDataSourceProtocol
    init(homeLocalDataSource: HomeDataSourceProtocol) {
        self.homeLocalDataSource = homeLocalDataSource
    }

    func getModelResult(url: URL) async throws -> [String: Double] {
        return try await homeLocalDataSource.getModelResult(url: url)
    }
}

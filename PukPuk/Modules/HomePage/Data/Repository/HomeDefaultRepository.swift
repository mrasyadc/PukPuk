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
    private let homeLocalDataSource: HomeLocalDataSourceProtocol
    init(homeLocalDataSource: HomeLocalDataSourceProtocol) {
        self.homeLocalDataSource = homeLocalDataSource
    }

    func getModelResult(url: URL) -> [String: Double] {
        return homeLocalDataSource.getModelResult(url: url)
    }
}

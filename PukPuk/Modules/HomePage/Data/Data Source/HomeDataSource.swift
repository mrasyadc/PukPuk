//
//  HomeDataSource.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

import Foundation

class HomeDataSource: HomeLocalDataSourceProtocol {
    func getModelResult(url: URL) -> [String: Double] {
        return ["A": 0.99, "B": 0.89]
    }
}

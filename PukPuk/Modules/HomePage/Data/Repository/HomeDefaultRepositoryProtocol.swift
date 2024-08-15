//
//  HomeDefaultRepositoryProtocol.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

import Foundation

protocol HomeDefaultRepositoryProtocol {
    func getModelResult(url: URL) async throws -> [String: Double]
}

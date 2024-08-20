//
//  ResultRepository.swift
//  PukPuk
//
//  Created by Jason Susanto on 19/08/24.
//

import Foundation

internal protocol ResultRepository {
    func getRecommendation(for classificationResult: ClassificationResult) -> RecommendationEntity
}

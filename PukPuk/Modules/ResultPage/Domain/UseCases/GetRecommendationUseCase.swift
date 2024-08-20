//
//  GetResultUseCase.swift
//  PukPuk
//
//  Created by Jason Susanto on 19/08/24.
//

import Foundation

internal final class GetRecommendationUseCase {
    
    private let repository: ResultRepository
    
    init(repository: ResultRepository) {
        self.repository = repository
    }
    
    func execute(for classificationResult: ClassificationResult) -> RecommendationEntity {
        repository.getRecommendation(for: classificationResult)
    }
}
